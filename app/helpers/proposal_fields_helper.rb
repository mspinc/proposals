module ProposalFieldsHelper
  def proposal_type_locations(proposal_type)
    proposal_type.locations.map { |loc| [loc.name, loc.id] }
  end

  def proposal_field_options(field)
    if field.options == "{}"
      []
    else
      options = []
      text_value = %w[value text]
      field.options.each do |k, v|
        options.push(v) if text_value.include?(k)
      end
      [options]
    end
  end
end
