class ProposalFieldsController < ApplicationController
  def new; end

  def field_type
    type = params[:field_type]
    @form = "ProposalFields::#{type}".constantize
    render partial: "proposal_fields/field_types/#{type.downcase}", locals: { form: @form.new }
  end
end
