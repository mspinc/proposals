class ProposalType < ApplicationRecord
  has_many :proposals, dependent: :destroy
  has_many :proposal_forms, dependent: :destroy
end
