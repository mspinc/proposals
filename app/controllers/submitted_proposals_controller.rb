class SubmittedProposalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @submitted_proposals = Proposal.where(status: :active)
  end

  def show
    @proposal = Proposal.find_by(id: params[:id])
  end
end
