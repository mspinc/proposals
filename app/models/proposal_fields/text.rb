module ProposalFields
  class Text < ApplicationRecord
    self.table_name = 'proposal_fields_texts'

    has_many :proposal_fields, as: :fieldable, dependent: :destroy
  end
end
