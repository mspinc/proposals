module SubmittedProposalsHelper

  def submitted_graph_data(param, param2, proposals)
    @data = Hash.new(0)
    proposals&.each do |proposal|
      citizenships = proposal.demographics_data.pluck(:result).pluck(param, param2).flatten.reject{ |s| s.blank? || s.eql?("Other")}

      citizenships.each do |c|
        @data[c] += 1
      end
    end
  end

  def submitted_nationality_data(proposals)
    submitted_graph_data("citizenships", "citizenships_other", proposals)
    @data
  end

  def submitted_ethnicity_data(proposals)
    submitted_graph_data("ethnicity", "ethnicity_other", proposals)
    @data
  end

  def submitted_gender_labels(proposals)
    submitted_graph_data("gender", "gender_other", proposals)
    @data.keys
  end

  def submitted_gender_values(proposals)
    submitted_graph_data("gender", "gender_other", proposals)
    @data.values
  end

  def submitted_career_data(param, param2, proposals)
    @data = Hash.new(0)
    proposals&.each do |proposal|
      person = Person.where.not(id: proposal.lead_organizer.id)
      careerStage = person.where(id: proposal.person_ids).pluck(param, param2).flatten.reject{ |s| s.blank? || s.eql?("Other")}

      careerStage.each do |s|
        @data[s] += 1
      end
    end
  end

  def submitted_career_labels(proposals)
    submitted_career_data("academic_status", "other_academic_status", proposals)
    @data.keys
  end

  def submitted_career_values(proposals)
    submitted_career_data("academic_status", "other_academic_status", proposals)
    @data.values
  end

  def submitted_stem_graph_data(proposals)
    @data = Hash.new(0)
    proposals&.each do |proposal|
      citizenships = proposal.demographics_data.pluck(:result).pluck("stem").flatten.reject{ |s| s.blank? || s.eql?("Other")}

      citizenships.each do |c|
        @data[c] += 1
      end
    end
  end

  def submitted_stem_labels(proposals)
    submitted_stem_graph_data(proposals)
    @data.keys
  end

  def submitted_stem_values(proposals)
    submitted_stem_graph_data(proposals)
    @data.values
  end
end
