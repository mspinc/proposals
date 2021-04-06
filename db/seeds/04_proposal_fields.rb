ProposalType.all.each do |proposal_type|
  proposal_type.proposal_forms.create!(status: :draft)
end

location = Location.find_or_create_by!(name: 'Canada')  
ProposalForm.all.each do |proposal_form|
  proposal_form.proposal_fields.find_or_create_by!(type: 'ProposalFields::Radio',
                                                  statement: "#{proposal_form.proposal_type.name} Is this organizer an early career researcher within 10 years of their doctoral degree?")
  proposal_form.proposal_fields.find_or_create_by!(type: 'ProposalFields::Text',
                                                  statement: "#{proposal_form.proposal_type.name} Please provide 1-2 paragraphs for a press release for your workshop. It should be understandable by the general public.")
  proposal_form.proposal_fields.find_or_create_by!(type: 'ProposalFields::Text',
                                                  statement: "#{proposal_form.proposal_type.name} A statement of the objectives of the workshop and an indication of its relevance, importance, and timeliness.")
  proposal_form.proposal_fields.find_or_create_by!(type: 'ProposalFields::Radio',
                                                  statement: "#{proposal_form.proposal_type.name} Is this organizer an early career researcher within 10 years of their doctoral degree?")
  proposal_form.proposal_fields.find_or_create_by!(type: 'ProposalFields::Text',
                                                  statement: "#{proposal_form.proposal_type.name} Please provide 1-2 paragraphs for a press release for your workshop. It should be understandable by the general public.")
  proposal_form.proposal_fields.find_or_create_by!(type: 'ProposalFields::Text',
                                                  statement: "#{proposal_form.proposal_type.name} A statement of the objectives of workshop and an indication of its relevance, importance, and timeliness.")
  proposal_form.proposal_fields.find_or_create_by!(type: 'ProposalFields::Radio',
                                                  statement: "#{proposal_form.proposal_type.name} Is this organizer an early career researcher within 10 years of their doctoral degree?")
  proposal_form.proposal_fields.find_or_create_by!(type: 'ProposalFields::Radio',
                                                  statement: "#{proposal_form.proposal_type.name} A statement of the objectives of the workshop and an indication of its relevance, importance, and timeliness.", location_id: location.id)
  proposal_form.proposal_fields.find_or_create_by!(type: 'ProposalFields::Text',
                                                  statement: "#{proposal_form.proposal_type.name} A short overview of the subject area of your workshop.", location_id: location.id)
end
