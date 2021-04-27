class ProposalFormsController < ApplicationController
  before_action :set_proposal_form, only: %i[edit]
  def index; end

  def new
    @proposal_form = ProposalForm.new
  end

  def edit
    @proposal_form.update(status: 'active')
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
