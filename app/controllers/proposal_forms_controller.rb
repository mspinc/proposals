class ProposalFormsController < ApplicationController
  before_action :set_proposal_type
  before_action :set_proposal_form, only: %i[edit update show clone proposal_field]
  
  def index
    @proposal_forms = @proposal_type&.proposal_forms
  end

  def new
    @proposal_form = ProposalForm.new
  end

  def edit; end

  def show
    redirect_to :index if @proposal_form.nil?
  end

  def update
    if @proposal_form.active?
      @proposal_form.update(status: :inactive)
      form = @proposal_form.deep_clone include: :proposal_fields
      form.status = :draft
      form.version += 1
      form.save
      params.require(:proposal_form).delete(:status)
      update_proposal_form(form)
    else
      update_proposal_form(@proposal_form)
    end
  end

  def create
    @proposal_form = ProposalForm.new(proposal_form_params)
    forms = @proposal_form.proposal_type.proposal_forms
    forms.update_all(status: :inactive)
    @proposal_form.created_by = current_user
    if @proposal_form.save
      redirect_to edit_proposal_type_proposal_form_path(@proposal_type, @proposal_form)
    else
      redirect_to new_proposal_type_proposal_form_path, alert: "Title can't be blank"
    end
  end

  def proposal_field
    @proposal_field = ProposalField.find_by(id: params[:field_id])
    @proposal_field.destroy
    redirect_to edit_proposal_type_proposal_form_path(@proposal_type, @proposal_form)
  end

  def clone
    proposal_type = ProposalType.find params[:proposal_type_id]
    proposal_type.proposal_forms.update_all(status: :inactive)
    proposal_form = @proposal_form.deep_clone include: :proposal_fields
    proposal_form.status = :draft
    proposal_form.proposal_type_id = params[:proposal_type_id]
    proposal_form.save
    redirect_to edit_proposal_type_proposal_form_path(@proposal_type, proposal_form)
  end

  private

  def set_proposal_type
    @proposal_type = ProposalType.find_by(id: params[:proposal_type_id])
  end

  def set_proposal_form
    @proposal_form = ProposalForm.find_by(id: params[:id])
  end

  def proposal_form_params
    params.require(:proposal_form).permit(:title, :status, :proposal_type_id).merge(updated_by: current_user)
  end

  def update_proposal_form(form)
    if form.update(proposal_form_params)
      redirect_to edit_proposal_type_proposal_form_path, notice: 'Proposal form was successfully updated'
    else
      redirect_to edit_proposal_type_proposal_form_path, status: :unprocessable_entity,
                    alert: "Unable to update proposal form."
    end
  end
end
