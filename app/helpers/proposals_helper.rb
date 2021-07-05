module ProposalsHelper
  def proposal_types
    ProposalType.active_forms.map { |pt| [pt.name, pt.id] }
  end

  def proposal_type_year(proposal_type)
    return [Date.current.year + 2] if proposal_type.year.blank?

    proposal_type.year&.split(",").map { |year| year }
  end

  def locations
    Location.all.map { |loc| [loc.name, loc.id] }
  end

  def all_proposal_types
    ProposalType.all.map { |pt| [pt.name, pt.id] }
  end

  def common_proposal_fields(proposal)
    proposal.proposal_form&.proposal_fields&.where(location_id: nil)
  end

  def proposal_roles(proposal_roles)
    proposal_roles.joins(:role).where(person_id: current_user.person&.id).pluck('roles.name').map(&:titleize).join(', ')
  end

  def lead_organizer?(proposal_roles)
    proposal_roles.joins(:role).where('person_id =? AND roles.name =?', current_user.person&.id,
                                      'lead_organizer').present?
  end

  def proposal_ams_subjects_code(proposal, code)
    proposal.ams_subjects.find_by_code(code)&.id
  end

  def organizer_intro(proposal)
    types_with_intro = ['5 Day Workshop', 'Summer School']
    return '' unless types_with_intro.include? proposal.proposal_type.name

    %q(<p>5-Day Workshops and Summer Schools require a minimum of 2, and a maximum of 4 total organizers per proposal. In accordance with BIRS' commitment to equity, diversity and inclusion (EDI), the organizing committee should contain at least one early-career researcher within ten years of their doctoral degree. For applications with two organizers, at least one member of the organizing committee must be from an under-represented community in STEM disciplines. For applications with three or more organizers, at least two members of the organizing committee must be from an under-represented community in STEM disciplines.</p>).html_safe
  end

  def existing_co_organizers(invite)
    co_organizers = invite.proposal.list_of_co_organizers.remove(invite.person&.fullname)
    co_organizers.prepend(" and ") if co_organizers.present?
    co_organizers.strip.delete_suffix(",")
  end

  def invite_status(response, status)
    return "Invite has been cancelled" if status == 'cancelled'

    case response
    when "yes", "maybe"
      "Invitation accepted"
    when nil
      "Not yet responded to invitation"
    when "no"
      "Invitation declined"
    end
  end

  def proposal_status(status)
    status == 'draft' ? "text-primary" : "text-success"
  end

  def invite_response_color(status)
    case status
    when "yes", "maybe"
      "text-success"
    when nil
      "text-primary"
    when "no"
      "text-danger"
    end
  end

  def graph_data(param, param2)
    citizenships = DemographicData.pluck(:result).pluck(param, param2).flatten.reject{ |s| s.blank? || s.eql?("Other")}
    @data = Hash.new(0)

    citizenships.each do |c|
      @data[c] += 1
    end
  end

  def nationality_data
    graph_data("citizenships", "citizenships_other")
    @data
  end

  def ethnicity_data
    graph_data("ethnicity", "ethnicity_other")
    @data
  end

  def gender_labels
    graph_data("gender", "gender_other")
    @data.keys
  end

  def gender_values
    graph_data("gender", "gender_other")
    @data.values
  end

  def stem_graph_data
    citizenships = DemographicData.pluck(:result).pluck("stem").flatten.reject{ |s| s.blank? || s.eql?("Other")}
    @data = Hash.new(0)

    citizenships.each do |c|
      @data[c] += 1
    end
  end

  def stem_labels
    stem_graph_data
    @data.keys
  end

  def stem_values
    stem_graph_data
    @data.values
  end
end
