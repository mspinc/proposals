class Proposal < ApplicationRecord
  has_many :proposal_locations, dependent: :destroy
  has_many :locations, through: :proposal_locations
  belongs_to :proposal_type
  has_many :proposal_roles, dependent: :destroy
  has_many :people, through: :proposal_roles
  has_many :answers, dependent: :destroy
  has_many :invites, dependent: :destroy
  belongs_to :proposal_form
  has_many :proposal_ams_subjects, dependent: :destroy
  has_many :ams_subjects, through: :proposal_ams_subjects
  belongs_to :subject, optional: true

  # validates_presence_of :year, :title
  # validate :create_code

  enum status: { draft: 0, active: 1 }

  scope :no_of_participants, -> (id, invited_as) {
    joins(:invites).where('invites.invited_as = ?
      AND invites.proposal_id = ?', invited_as, id)
  }

  scope :submitted, -> (type) {
    where(status: 1)
    .joins(:proposal_type).where('name = ?', type)
  }

  def lead_organizer
  	proposal_roles.joins(:role).find_by('roles.name = ?', 'lead_organizer')&.person
  end

  def the_locations
    locations.pluck(:name).join(', ')
  end


  private

  def next_number
    last_code = Proposal.submitted(proposal_type.name)
                        .pluck(:code).sort.last
    return '001' if last_code.blank?
    (last_code[-3..-1].to_i + 1).to_s.rjust(3, '0')
  end

  def create_code
    return true if !code.blank? || year.blank?

    # temporary, until type-code feature is added to ProposalTypes
    type_codes = {
      '5 Day Workshop' => 'w5',
      '2 Day Workshop' => 'w2',
      'Summer School' => 'ss',
      'Focussed Research Group' => 'frg',
      'Research in Teams' => 'rit',
      'Hybrid Thematic Program' => 'htp'
    }

    tc = type_codes[proposal_type.name] || 'xx'
    self.code = year.to_s[-2..-1] + tc + next_number
  end
end
