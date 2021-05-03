class ProposalForm < ApplicationRecord
  belongs_to :proposal_type
  has_many :proposal_fields, dependent: :destroy
  enum status: { draft: 0, active: 1 }
end
