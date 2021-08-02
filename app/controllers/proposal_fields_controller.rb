class ProposalFieldsController < ApplicationController
  before_action :set_proposal_form, only: %i[new create edit update]
  before_action :set_proposal_field, only: %i[edit update]

  def new
    if %w[Date Radio Text SingleChoice MultiChoice PreferredImpossibleDate File].include?(params[:field_type])
      type = "ProposalFields::#{params[:field_type]}".safe_constantize.new
      @proposal_field = @proposal_form.proposal_fields.new(fieldable: type)
      render partial: 'proposal_fields/fields_form',
             locals: { proposal_field: @proposal_field, proposal_form: @proposal_form }
    else
      redirect_to edit_proposal_type_proposal_form_url(@proposal_form.proposal_type, @proposal_form),
                  alert: "Invalid field type"
    end
  end

  # rubocop:disable Metrics/AbcSize
  def create
    if %w[Date Radio Text SingleChoice MultiChoice PreferredImpossibleDate File].include?(params[:type])
      @fieldable = "ProposalFields::#{params[:type]}".safe_constantize.new(date_field_params)
    end
    @proposal_field = @proposal_form.proposal_fields.new(proposal_field_params)
    @proposal_field.fieldable = @fieldable
    if @proposal_field.insert_at(@proposal_field.position)
      @proposal_form.update(updated_by: current_user)
      redirect_to edit_proposal_type_proposal_form_url(@proposal_form.proposal_type, @proposal_form),
                  notice: "Field was successfully created."
    else
      redirect_to edit_proposal_type_proposal_form_url(@proposal_form.proposal_type, @proposal_form),
                  alert: @proposal_form.errors
    end
  end
  # rubocop:enable Metrics/AbcSize

  def edit
    render partial: 'proposal_fields/fields_form',
           locals: { proposal_field: @proposal_field, proposal_form: @proposal_form }
  end

  def update
    if @proposal_field.update(proposal_field_params) && @proposal_field.fieldable.update(date_field_params)
      @proposal_form.update(updated_by: current_user)
      redirect_to edit_proposal_type_proposal_form_url(@proposal_form.proposal_type, @proposal_form),
                  notice: "Field was successfully updated."
    else
      redirect_to edit_proposal_type_proposal_form_url(@proposal_form.proposal_type, @proposal_form),
                  alert: @proposal_form.errors
    end
  end

  private

  def proposal_field_params
    params.require(:proposal_field).permit(:position, :description, :location_id, :statement, :guideline_link,
                                           validations_attributes: %i[id _destroy validation_type value error_message],
                                           options_attributes: %i[id index value text _destroy])
  end

  def set_proposal_form
    @proposal_form = ProposalForm.find_by(id: params[:proposal_form_id])
  end

  def set_proposal_field
    @proposal_field = ProposalField.find_by(id: params[:id])
  end

  def date_field_params
    param = params.require(:proposal_field)[:proposal_fields_preferred_impossible_date]
    return {} unless param

    param.permit(:preferred_dates_1, :preferred_dates_2, :preferred_dates_3, :preferred_dates_4,
                 :preferred_dates_5, :impossible_dates_1, :impossible_dates_2)
  end
end
