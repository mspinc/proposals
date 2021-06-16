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

    proposal_details
    proposal_organizers
    proposal_locations
    proposal_subjects
    user_defined_fields
    proposal_participants
    @text
  end

  def proposal_details
    code = proposal.code.blank? ? '' : "#{proposal.code}: "
    @text = "\\section*{\\centering #{code} #{proposal.title} }\n\n"
    @text << "\\subsection*{#{proposal.proposal_type&.name} }\n\n"
    @text << "#{proposal.invites.count} participants\n\n"

    @text << "\\subsection*{Lead Organiser}\n\n"
    @text << "#{proposal.lead_organizer&.fullname}  \\\\ \n\n"
    # unless proposal.lead_organizer&.address.blank?
    #   @text << "#{proposal.lead_organizer.address}  \\\\ \n\n"
    # end
    @text << "\\noindent #{proposal.lead_organizer&.email}\n\n"
  end

  def proposal_organizers
    return if proposal.supporting_organizers.count.zero?

    @text << "\\subsection*{Supporting Organisers}\n\n"
    proposal.supporting_organizers.each do |organiser|
      @text << "#{organiser.firstname} #{organiser.lastname}\n\n"
    end
  end

  def proposal_locations
    @text << "\\subsection*{Preferred Location(s)}\n\n"
    proposal.locations.each do |location|
      @text << "#{location.name}\n\n"
    end
  end

  def proposal_subjects
    @text << "\\subsection*{Subject Areas}\n\n"
    @text << "#{proposal.subject&.title} \\\\ \n"
    @text << "\\noindent #{proposal.ams_subjects
                                   .where(code: 'code1').first&.title} \\\\ \n"
    @text << "\\noindent #{proposal.ams_subjects
                                   .where(code: 'code2').first&.title} \\\\ \n"
  end

  def user_defined_fields
    proposal.answers.each do |field|
      if field.proposal_field.fieldable_type == "ProposalFields::PreferredImpossibleDate"
        preferred_impossible_dates(field)
        next
      end
      @text << "\\subsection*{#{field.proposal_field.statement}}\n\n"
      @text << "\\noindent #{field.answer}\n\n"
    end
  end

  def proposal_participants
    return if proposal.participants.count.zero?

    @text << "\\subsection*{Participants}\n\n"
    @text << "\\begin{enumerate}\n\n"
    proposal.participants.each do |participant|
      @text << "\\item #{participant.firstname} #{participant.lastname} \n"
    end
    @text << "\\end{enumerate}\n\n"
  end

  def preferred_impossible_dates(field)
    #@text << "\\subsection*{#{field.proposal_field.statement}}\n\n"
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
