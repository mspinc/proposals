class Invite < ApplicationRecord
  validates :firstname, :lastname, :email, :invited_as, :deadline_date, presence: true
  validate :proposal_title
  enum status: { pending: 0, confirmed: 1 }
  enum response: { yes: 0, maybe: 1, no: 2 }

  belongs_to :person
  belongs_to :proposal

  before_save :generate_code
  validate :deadline_not_in_past
  validates_uniqueness_of :email, scope: :proposal_id, message: "Same email cannot be used to invite already invited organizers or participants"

  def generate_code
    self.code = SecureRandom.urlsafe_base64(37) if self.code.blank?
  end

  def proposal_title
    return if self.proposal.nil?
    if proposal.title.blank?
      errors.add('Proposal Title:', 'Please add a title, and click
        "Save as Draft", before adding people.'.squish)
    end
  end

  def deadline_not_in_past
    return if deadline_date.nil?
    errors.add('Deadline', "can't be in past") if deadline_date < Date.current
  end
  
  def invited_as?
    invited_as == 'Co Organizer' ? 'Supporting Organizer' : 'Participant'
  end
end
