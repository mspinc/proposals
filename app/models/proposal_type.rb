class ProposalType < ApplicationRecord
  validates :name, presence: true
  has_many :proposals, dependent: :destroy
  has_many :proposal_forms, dependent: :destroy
  has_many :proposal_type_locations, dependent: :destroy
  has_many :locations, through: :proposal_type_locations
end
