module ProposalFields
  class SingleChoice < ApplicationRecord
    self.table_name = 'proposal_fields_single_choices'

    has_many :proposal_fields, as: :fieldable, dependent: :destroy
    has_many :options, as: :optionable, dependent: :destroy
  end
end
