ProposalType.all.each do |proposal_type|
  proposal_type.proposal_forms.create!(status: :draft)
end

location = Location.find_or_create_by!(name: 'Canada')
ProposalForm.all.each do |proposal_form|
  fieldable = ProposalFields::Text.create!(statement: 'A short overview of the subject area of your workshop.')
  proposal_form.proposal_fields.create!(fieldable: fieldable)
end
