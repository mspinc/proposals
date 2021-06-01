module ProposalFieldsHelper
  def proposal_type_locations(proposal_type)
    proposal_type.locations.map { |loc| [loc.name, loc.id] }
  end

  def proposal_field_options(field)
    if field.options == "{}"
      []
    else
      options = []
      field.options.each do |option|
        options.push([option.last["text"], option.last["value"]])
      end
      options
    end
  end

  def options(field)
    if field.options == "{}"
      []
    else
      opt = []
      field.options.each do |option|
        opt.push(option.last['text'])
      end
      opt
    end
  end

  def options_for_field(field)
    if field.fieldable_type.in?(%w[ProposalFields::SingleChoice ProposalFields::MultiChoice ProposalFields::Radio])
      options(field.fieldable)
    end
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

  def proposal_field_partial(field)
    "proposal_fields/#{field.fieldable_type.split('::').last.underscore}"
  end
end
