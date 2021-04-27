class ProposalField < ApplicationRecord
  belongs_to :proposal_form
  belongs_to :location, optional: true

  FIELD_TYPES = %w[Radio Text]
end
