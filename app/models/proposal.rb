class Proposal < ApplicationRecord
  has_many :proposal_locations, dependent: :destroy
  has_many :locations, through: :proposal_locations
  belongs_to :proposal_type
  has_many :proposal_roles, dependent: :destroy
  has_many :people, through: :proposal_roles
  has_many :answers, dependent: :destroy
  has_many :invites

  enum status: { draft: 0, active: 1 }
end
