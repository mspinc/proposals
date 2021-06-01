class Invite < ApplicationRecord
  validates :firstname, :lastname, :email, :invited_as, presence: true
  enum status: { pending: 0, completed: 1 }
  enum response: { yes: 0, maybe: 1, no: 2 }

  belongs_to :person
  belongs_to :proposal
end
