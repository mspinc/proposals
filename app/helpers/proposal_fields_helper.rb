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
    opt = []
    field.options.each do |option|
      opt.push(option.last['text'])
    end
    opt
  end
end
