class Invite < ApplicationRecord
  validates :firstname, :lastname, :email, :invited_as, presence: true
  enum status: { pending: 0, completed: 1 }
  enum response: { 'n/a': 0, yes: 1, maybe: 2, no: 3 }

  belongs_to :person
  belongs_to :proposal
end
