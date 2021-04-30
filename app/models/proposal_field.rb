class ProposalField < ApplicationRecord
  belongs_to :proposal_form
  belongs_to :location, optional: true
  belongs_to :fieldable, polymorphic: true

  FIELD_TYPES = %w[Radio Text SingleChoice MultiChoice].freeze

  default_scope { order(index: :asc) }
end
