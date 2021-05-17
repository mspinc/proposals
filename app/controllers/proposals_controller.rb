class ProposalsController < ApplicationController
  before_action :set_proposal, only: %w[edit destroy]
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
    if @proposal.save
      @proposal.proposal_roles.create!(person: current_user.person, role: organizer)
      redirect_to edit_proposal_path(@proposal)
    else
      render :new
    end
  end

  def edit; end

  def destroy
    @proposal.destroy
    respond_to do |format|
      format.html { redirect_to proposals_url, notice: "Proposal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:proposal_type_id)
  end

  def organizer
    Role.find_or_create_by!(name: 'Organizer')
  end

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end
end
