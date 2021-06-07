module ProposalTypesHelper
  def list_proposal_locations(proposal_type)
    return '' if proposal_type.locations.empty?

    proposal_type.locations.map(&:name).join("<br>\n").html_safe
  end
end
