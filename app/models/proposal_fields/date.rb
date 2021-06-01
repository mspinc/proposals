module ProposalFields
  class Date < ApplicationRecord
    self.table_name = 'proposal_fields_dates'

    has_many :proposal_fields, as: :fieldable, dependent: :destroy
  end
end
