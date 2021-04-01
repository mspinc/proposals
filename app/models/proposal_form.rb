class ProposalForm < ApplicationRecord
  belongs_to :proposal_type
  has_many :proposal_fields
  enum status: %i[draft active]
end
