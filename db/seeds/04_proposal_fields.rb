ProposalType.first.proposal_forms.create!(status: :draft)

ProposalForm.first.proposal_fields.find_or_create_by!(type: 'ProposalFields::Radio', statement: 'Is this organizer an early career researcher within 10 years of their doctoral degree?')
ProposalForm.first.proposal_fields.find_or_create_by!(type: 'ProposalFields::Text', statement: 'Please provide 1-2 paragraphs for a press release for your workshop. It should be understandable by the general public.')
ProposalForm.first.proposal_fields.find_or_create_by!(type: 'ProposalFields::Text', statement: 'A statement of the objectives of the workshop and an indication of its relevance, importance, and timeliness.')

location = Location.find_or_create_by!(name: 'Canada')	

ProposalForm.first.proposal_fields.find_or_create_by!(type: 'ProposalFields::Text', statement: 'A statement of the objectives of the workshop and an indication of its relevance, importance, and timeliness.', location_id: location.id)
ProposalForm.first.proposal_fields.find_or_create_by!(type: 'ProposalFields::Text', statement: 'A short overview of the subject area of your workshop.', location_id: location.id)
