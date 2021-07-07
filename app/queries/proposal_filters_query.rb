# frozen_string_literal: true

class ProposalFiltersQuery

  def initialize(relation)
    @result = relation
  end
  
  def find(params = {})
    @result = filter_by_first_name(params[:firstname])
    @result = filter_by_last_name(params[:lastname])
    @result = filter_by_subject_area(params[:subject_area])
    @result = filter_by_keyword(params[:keywords])
    @result = filter_by_workshop_year(params[:workshop_year])
    @result = filter_by_proposal_type(params[:proposal_type])

    @result
  end
  
  def filter_by_first_name(firstname)
    return @result unless firstname.present?

    @result.search_proposals(firstname)
  end

  def filter_by_last_name(lastname)
    return @result unless lastname.present?

    @result.search_proposals(lastname)
  end

  def filter_by_subject_area(subject_area)
    return @result unless subject_area.present?

    @result.search_proposals(subject_area)
  end

  def filter_by_keyword(keywords)
    return @result unless keywords.present?

    if keywords == "active"
      @result.search_proposals(1)
    elsif keywords == "draft"
      @result.search_proposals(0)
    else
      @result.search_proposals(keywords)
    end
  end

  def filter_by_workshop_year(workshop_year)
    return @result unless workshop_year.present?

    @result.search_proposals(workshop_year)
  end

  def filter_by_proposal_type(proposal_type)
    return @result unless proposal_type.present?

    @result.search_proposals(proposal_type)
  end
end
