class ProposalType < ApplicationRecord
  validates :name, :participant, :co_organizer,  presence: true
  has_many :proposals, dependent: :destroy
  has_many :proposal_forms, dependent: :destroy
  has_many :proposal_type_locations, dependent: :destroy
  has_many :locations, through: :proposal_type_locations

  scope :active_forms, -> { joins(:proposal_forms).where('proposal_forms.status =?', 1).distinct }

  def active_form
    proposal_forms.where('proposal_forms.status =?', 1).last
  end

  def lead_organizer?(person_id)
    proposals.joins(proposal_roles: :role)
             .where("proposal_roles.person_id =?", person_id)
             .where('roles.name =?', 'lead_organizer').empty?
  end
end
