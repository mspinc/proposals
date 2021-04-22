class Person < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true
  belongs_to :user, optional: true
  has_many :proposal_roles, dependent: :destroy
end
