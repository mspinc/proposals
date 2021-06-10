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
      redirect_to new_proposal_path, alert: @proposal.errors.full_messages
    end
  end

  def show; end

  def edit
    @publish = params[:publish]
  end

  def text
    @text = session[:latex_text]
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
    @proposal = Proposal.find(params[:id])
  end
end
