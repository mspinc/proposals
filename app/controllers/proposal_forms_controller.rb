class ProposalFormsController < ApplicationController
  before_action :set_proposal_form, only: %i[edit update]

  def new
    @proposal_form = ProposalForm.new
  end

  def edit; end

  def update
    @proposal_form.update(status: 'active')
    redirect_to edit_proposal_form_path(@proposal_form)
  end

  def create
    @proposal_form = ProposalForm.new(status: 'draft', proposal_type_id: params[:proposal_type])
    @proposal_form.save
    redirect_to edit_proposal_form_path(@proposal_form)
  end

  private

  def set_proposal_form
    @proposal_form = ProposalForm.find_by(id: params[:id])
  end
end
