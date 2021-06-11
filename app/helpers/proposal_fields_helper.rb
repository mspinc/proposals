module ProposalFieldsHelper
  def proposal_type_locations(proposal_type)
    proposal_type.locations.map { |loc| ["#{loc.name} (#{loc.city}, #{loc.country})", loc.id] }
  end

  def proposal_field_options(field)
    options = []
    field.options.each do |option|
      options.push([option.text, option.value])
    end
    options
  end

  def options(field)
    opt = []
    field.options.each do |option|
      opt.push(option.text)
    end
    opt
  end

  def options_for_field(field)
    return unless field.fieldable_type.in?(%w[ProposalFields::SingleChoice ProposalFields::MultiChoice
                                              ProposalFields::Radio])

    options(field)
  end

  def answer(field, proposal)
    return unless proposal

    Answer.find_by(proposal_field_id: field.id, proposal_id: proposal.id)&.answer
  end

  def multichoice_answer(field, proposal)
    return unless proposal

    answer = Answer.find_by(proposal_field_id: field.id, proposal_id: proposal.id)&.answer
    if answer
      JSON.parse(answer)
    else
      answer
    end
  end

  def location_in_answers(proposal)
    proposal.locations.pluck(:id)
  end

  def validations(field, proposal)
    return [] if field.location_id && @proposal.locations.exclude?(field.location)

    ProposalFieldValidationsService.new(field, proposal).validations
  end

  def proposal_field_partial(field)
    "proposal_fields/#{field.fieldable_type.split('::').last.underscore}"
  end

  def preferred_impossible_dates(field, attr)
    field.fieldable[attr].split(",").map { |date| [date, date] }
  end

  def dates_answer(field, proposal, attr)
    ans = answer(field, proposal)
    if ans
      dates = JSON.parse(ans)[attr.to_i]
    else
      ans
    end
  end

  def action
    params[:action] == 'show' || (params[:action] == 'location_based_fields' && request.referer.exclude?('edit'))
  end

  def mendatory_field?(field)
    field.validations.where(validation_type: 'mandatory').present?
  end

  def print_validation
    '<span style="color:red; margin-left: 3px;">*</sapn>'.html_safe
  end

end
