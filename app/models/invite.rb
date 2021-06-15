class Invite < ApplicationRecord
  validates :firstname, :lastname, :email, :invited_as, :deadline_date, presence: true
  validate :proposal_title
  enum status: { pending: 0, completed: 1 }
  enum response: { yes: 0, maybe: 1, no: 2 }

  belongs_to :person
  belongs_to :proposal

  before_save :generate_code

  def generate_code
    self.code = SecureRandom.urlsafe_base64(37) if self.code.blank?
  end

  def proposal_title
    return if self.proposal.nil?
    if proposal.title.blank?
      errors.add('Proposal Title:', 'Please add a title, and click
        "Save as Draft" before adding people.'.squish)
    end
  end
end
