class ProposalPdfService
  attr_reader :proposal, :temp_file

  def initialize(proposal_id, file, input)
    @proposal = Proposal.find(proposal_id)
    @temp_file = file
    @input = input
  end

  def pdf
    input = @input.presence || 'Please enter some text.'

    input = all_proposal_fields if @input == 'all'
    File.open("#{Rails.root}/tmp/#{temp_file}", 'w:binary') do |io|
      io.write(input)
    end
  end

  private

  def all_proposal_fields
    return 'Proposal data not found!' if proposal.blank?

    proposal_detail
    proposal_participants
    proposal_locations

    proposal.answers.each do |field|
      if field.proposal_field.fieldable_type == "ProposalFields::PreferredImpossibleDate"
        possible_impossible_dates(field)
        next
      end
      @text << "\\subsection*{#{field.proposal_field.statement}}\n\n"
      @text << "#{field.answer}\n\n"
    end
    @text
  end

  def proposal_detail
    @text = "\\section*{\\centering #{proposal.code}: #{proposal.title} }\n\n"
    @text << "#{proposal.proposal_form.introduction}\n\n"
    @text << "\\subsection*{#{proposal.proposal_type&.name} }\n\n"
    @text << "#{proposal.invites.count} participants\n\n"

    @text << "\\subsection*{ Subject Areas}\n\n"
    @text << "#{proposal.subject&.title}\n\n"
  end

  def proposal_participants
    if proposal.lead_organizer
      @text << "\\section*{ Contact Organiser}\n\n"
      @text << "#{proposal.lead_organizer&.fullname}\n\n"
    end

    return if proposal.invites.count.zero?

    @text << "\\section*{Other Organizers}\n\n"
    proposal.invites.each do |organiser|
      @text << "#{organiser.firstname} #{organiser.lastname} \n\n"
    end
  end

  def proposal_locations
    @text << "\\section*{Preferred Location(s)}\n\n"
    proposal.locations.each do |loc|
      @text << "#{loc.name}\n\n"
    end
  end

  def possible_impossible_dates(field)
    @text << "\\subsection*{#{field.proposal_field.statement}}\n\n"
    @text << "\\subsection*{Preferred dates}\n\n"
    possible = JSON.parse(field.answer)&.first(5)
    possible.each do |date|
      @text << "#{date}\n\n"
    end

    impossible = JSON.parse(field.answer)&.last(2)
    @text << "\\subsection*{Impossible dates}\n\n"

    impossible.each do |date|
      @text << "#{date}\n\n"
    end
  end
end
