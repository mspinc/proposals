module ProposalsHelper
  def proposal_types
    ProposalType.all.map { |pt| [pt.name, pt.id] }
  end

  def locations
    Location.all.map { |loc| [loc.name, loc.id] }
  end
end
