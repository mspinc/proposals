class SubmitProposalsController < ApplicationController
  def new
    @proposal = ProposalForm.new
  end

  def create; end
end
