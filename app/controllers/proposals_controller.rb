class ProposalsController < ApplicationController
  before_action :set_proposal, only: %w[edit]
  
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
    end
  end

  def edit; end

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
