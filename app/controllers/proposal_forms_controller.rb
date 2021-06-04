class ProposalFormsController < ApplicationController
  before_action :set_proposal_form, only: %i[edit update show clone proposal_field]

  def new
    @proposal_form = ProposalForm.new
  end

  def edit

  end

  def show
    redirect_to :index if @proposal_form.nil?
  end

  def update
    if @proposal_form.active?
      @proposal_form.update(status: 'inactive')
      params.require(:proposal_form).delete(:status)
    end

    if @proposal_form.update(proposal_form_params)
      version = @proposal_form.version + 1
      @proposal_form.update(version: version)
      redirect_to @proposal_form, notice: 'Proposal form was successfully updated'
    else
      render :edit, status: :unprocessable_entity,
                    alert: "Unable to update proposal form."
    end
  end

  def create
    @proposal_form = ProposalForm.new(proposal_form_params)
    @proposal_form.created_by = current_user
    if @proposal_form.save
      redirect_to edit_proposal_form_path(@proposal_form, proposal_type_id: @proposal_form.proposal_type.id)
    else
      render :new, alert: 'Error saving proposal'
    end
  end

  def proposal_field
    @proposal_field = ProposalField.find_by(id: params[:field_id])
    @proposal_field.destroy
    redirect_to edit_proposal_form_path(@proposal_form)
  end

  def clone
    proposal_form = @proposal_form.deep_clone include: :proposal_fields
    proposal_form.status = 'active'
    proposal_form.save
    redirect_to edit_proposal_form_path(proposal_form, proposal_type_id: @proposal_form.proposal_type.id)
  end

  private

  def set_proposal_type
    @proposal_type = ProposalType.find(params[:proposal_type])
  end

  def set_proposal_form
    @proposal_form = ProposalForm.find_by(id: params[:id])
  end

  def proposal_form_params
    params.require(:proposal_form).permit(:title, :status, :proposal_type_id).merge(updated_by: current_user)
  end
end
