module ProposalFields
  class SingleChoice < ApplicationRecord
  	self.table_name = 'proposal_fields_single_choices'
  	
  	has_many :proposal_fields, as: :fieldable
  end
end
