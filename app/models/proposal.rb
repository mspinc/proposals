class Proposal < ApplicationRecord
  has_many :proposal_locations, dependent: :destroy
  has_many :locations, through: :proposal_locations
  belongs_to :proposal_type
  has_many :proposal_roles, dependent: :destroy
  has_many :people, through: :proposal_roles
  has_many :answers, dependent: :destroy
  has_many :invites, dependent: :destroy
  belongs_to :proposal_form
  enum status: { draft: 0, active: 1 }

  def lead_organizer
  	proposal_roles.joins(:role).find_by('roles.name = ?', 'lead_organizer')&.person
  end
end
