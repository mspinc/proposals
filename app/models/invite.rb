class Invite < ApplicationRecord
  validates :firstname, :lastname, :email, :invited_as, :deadline_date, presence: true
  enum status: { pending: 0, completed: 1 }
  enum response: { yes: 0, maybe: 1, no: 2 }

  belongs_to :person
  belongs_to :proposal

  before_save :generate_code

  def generate_code
    self.code = SecureRandom.urlsafe_base64(37) if self.code.blank?
  end
end
