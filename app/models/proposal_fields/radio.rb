module ProposalFields
  class Radio < ApplicationRecord
    self.table_name = 'proposal_fields_radios'

    has_many :proposal_fields, as: :fieldable, dependent: :destroy
  end
end
