module ProposalsHelper
  def proposal_types
    ProposalType.active_forms.map { |pt| [pt.name, pt.id] }
  end

  def proposal_type_year(proposal_type)
    proposal_type.year&.split(",").map { |year| year}
  end

  def locations
    Location.all.map { |loc| [loc.name, loc.id] }
  end
  
  def all_proposal_types
    ProposalType.all.map { |pt| [pt.name, pt.id] }
  end
  
  def common_proposal_fields(proposal_type)
    proposal_form = ProposalForm.active_form(proposal_type.id)
    proposal_form&.proposal_fields&.where(location_id: nil)
  end

  def proposal_roles(proposal_roles)
    proposal_roles.joins(:role).where(person_id: current_user.person&.id).pluck('roles.name').map(&:titleize).join(', ')
  end

  def lead_organizer?(proposal_roles)
    proposal_roles.joins(:role).where('person_id =? AND roles.name =?', current_user.person&.id, 'lead_organizer').present?
  end
end
