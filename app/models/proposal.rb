class Proposal < ApplicationRecord
  attr_accessor :is_submission

  has_many :proposal_locations, dependent: :destroy
  has_many :locations, through: :proposal_locations
  belongs_to :proposal_type
  has_many :proposal_roles, dependent: :destroy
  has_many :people, through: :proposal_roles
  has_many :answers, -> { order 'answers.proposal_field_id' }, dependent: :destroy
  has_many :invites, dependent: :destroy
  belongs_to :proposal_form
  has_many :proposal_ams_subjects, dependent: :destroy
  has_many :ams_subjects, through: :proposal_ams_subjects
  belongs_to :subject, optional: true

  validates_presence_of :year, :title, if: :is_submission
  validate :subjects, if: :is_submission
  validate :minimum_organizers, if: :is_submission
  validate :preferred_locations, if: :is_submission
  # validate :not_before_opening, if: :is_submission
  before_save :create_code, if: :is_submission

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
  	proposal_roles.joins(:role).find_by('roles.name = ?',
                                        'lead_organizer')&.person
  end

  def the_locations
    locations.pluck(:name).join(', ')
  end

  def list_of_co_organizers
    invites.where('invites.invited_as = ?',
      'Co Organizer').map(&:person).map(&:fullname).join(', ')
  end

  def supporting_organizers
    invites.where(invited_as: 'Co Organizer').where(status: 'confirmed')
  end

  def participants
    invites.where(invited_as: 'Participant').where(status: 'confirmed')
  end


  private

  # Temporary, until open/close feature is added
  def not_before_opening
    if DateTime.current < DateTime.parse('2020-07-15 00:01')
      errors.add('Early submission', 'Proposal submissions are not allowed
        until July 15th, 2021.'.squish)
    end
  end

  def minimum_organizers
    if invites.select { |i| i.status == 'confirmed' }.count < 1
      errors.add('Supporting Organizers: ', 'At least one supporting organizer
        must confirm their participation by following the link in the email
        that was sent to them.'.squish)
    end
  end

  def subjects
    errors.add('Subject Area:', "please select a subject area") if subject.nil?
    unless ams_subjects.pluck(:code).count == 2
      errors.add('AMS Subjects:', 'please select 2 AMS Subjects')
    end
  end

  def next_number
    codes = Proposal.submitted(proposal_type.name).pluck(:code)
    last_code = codes.reject { |c| c.to_s.empty? }.sort.last

    return '001' if last_code.blank?
    (last_code[-3..-1].to_i + 1).to_s.rjust(3, '0')
  end

  def create_code
    return unless self.code.blank?
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

  def preferred_locations
    errors.add('Preferred Locations:', "Please select at least one preferred location") if locations.empty?
  end
end
