class ProposalFieldsController < ApplicationController
  before_action :set_proposal_form, only: %i[new create]

  def new
    type = "ProposalFields::#{params[:field_type]}".constantize
    @proposal_field = @proposal_form.proposal_fields.new(type: type)
    render partial: 'proposal_fields/fields_form',
           locals: { proposal_field: @proposal_field, proposal_form: @proposal_form }
  end

  def create
    @proposal_field = @proposal_form.proposal_fields.new(proposal_field_params)
    @proposal_field.type = "ProposalFields::#{params[:type]}"
    if @proposal_field.save
      redirect_to edit_proposal_form_path(@proposal_form), notice: "Field was successfully created."
    else
      redirect_to edit_proposal_form_path(@proposal_form), alert: @proposal_form.errors
    end
  end

  private

  def proposal_field_params
    case params[:type]
    when 'Radio'
      radio_type_params
    when 'Text'
      text_type_params
    end
  end

  def set_proposal_form
    @proposal_form = ProposalForm.find(params[:proposal_form_id])
  end

  def radio_type_params
    params.require(:proposal_fields_radio).permit(:statement, :location_id)
  end

  def text_type_params
    params.require(:proposal_fields_text).permit(:statement, :location_id)
  end
end
