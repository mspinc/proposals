class ProposalsController < ApplicationController
  before_action :set_proposal, only: %w[show edit update destroy]
  before_action :authenticate_user!
  
  def index
    @proposals = current_user&.person&.proposals
  end

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.status = :draft
    @proposal.proposal_form = ProposalForm.active_form(@proposal.proposal_type_id)

    if @proposal.save
      @proposal.proposal_roles.create!(person: current_user.person, role: organizer)
      redirect_to edit_proposal_path(@proposal), notice: "Started a new #{@proposal.proposal_type.name} proposal!"
    else
      redirect_to new_proposal_path, alert: @proposal.errors #.full_messages
    end
  end

  def show; end

  def edit
    @invite = @proposal.invites.new
  end

  # POST /proposals/:1/latex
  def latex_input
    proposal_id = latex_params[:proposal_id]
    session[:proposal_id] = proposal_id

    temp_file = "propfile-#{current_user.id}-#{proposal_id}.tex"
    session[:latex_file] = temp_file
    input = latex_params[:latex]

    ProposalPdfService.new(proposal_id, temp_file, input).pdf

    head :ok
  end

  # GET /proposals/rendered_proposal.pdf
  def latex_output
    prop_id = session[:proposal_id]
    return if prop_id.blank?

    @proposal = Proposal.find_by_id(prop_id)
    @year = @proposal&.year || Date.current.year.to_i + 2

    fh = File.open("#{Rails.root}/tmp/#{session[:latex_file]}")
    @latex_input = fh.read

    begin
      render layout: "application", inline: "#{@latex_input}", formats: [:pdf]
    rescue ActionView::Template::Error => error
      flash[:alert] = "There are errors in your LaTeX code. Please see the
                        output from the compiler, and the LaTeX document,
                        below".squish
      error_output = ProposalPdfService.format_errors(error)
      render layout: "latex_errors", inline: "#{error_output}", formats: [:html]
    end
  end

  def destroy
    @proposal.destroy
    respond_to do |format|
      format.html { redirect_to proposals_url, notice: "Proposal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:proposal_type_id, :title, :year)
  end

  def organizer
    Role.find_or_create_by!(name: 'lead_organizer')
  end

  def set_proposal
    @proposal = Proposal.find_by_id(params[:id])
    @submission = session[:is_submission]
  end

  def latex_params
    params.permit(:latex, :proposal_id, :format)
  end
end
