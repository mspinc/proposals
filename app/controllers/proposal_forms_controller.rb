class ProposalFormsController < ApplicationController
  before_action :set_proposal_form, only: %i[edit update show destroy]

  def index
    @proposal_forms = ProposalForm.all
  end

  def index
    @proposal_forms = ProposalForm.all
  end

  def new
    @proposal_form = ProposalForm.new
  end

  def edit; end

  def show; end

  def update
    @proposal_form.update(status: 'active', updated_by: current_user)
    redirect_to edit_proposal_form_path(@proposal_form)
  end

  def create
    @proposal_form = ProposalForm.new(status: 'draft', proposal_type_id: params[:proposal_type])
    @proposal_form.created_by = current_user
    @proposal_form.updated_by = current_user
    @proposal_form.save
    redirect_to edit_proposal_form_path(@proposal_form)
  end

  def destroy
    @proposal_form.destroy
    respond_to do |format|
      format.html { redirect_to proposal_forms_url, notice: "Proposal form was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_proposal_form
    @proposal_form = ProposalForm.find_by(id: params[:id])
  end
end
