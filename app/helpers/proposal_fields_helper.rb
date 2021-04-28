module ProposalFieldsHelper
  def proposal_type_locations(proposal_type)
    proposal_type.locations.map { |loc| [loc.name, loc.id] }
  end
end
