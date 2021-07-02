class SubmittedProposalsController < ApplicationController
  before_action :authenticate_user!

  def index
    if query_params?
      query = ProposalFiltersQuery.new(Proposal.active_proposals)
      @proposals = query.find(params)
    else
      @proposals = Proposal.active_proposals
    end
  end

  def show
    @proposal = Proposal.find_by(id: params[:id])
  end

  private

  def query_params?
    params[:firstname].present? || params[:lastname].present? || 
    params[:subject_area].present? || params[:keywords].present? || 
    params[:workshop_year].present?
  end
end
