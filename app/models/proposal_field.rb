class ProposalField < ApplicationRecord
  validates :statement, presence: true
  belongs_to :proposal_form
  belongs_to :location, optional: true
  belongs_to :fieldable, polymorphic: true
  has_one :answer

  FIELD_TYPES = %w[Radio Text SingleChoice MultiChoice].freeze

  default_scope { order(index: :asc) }
end
