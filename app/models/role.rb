class Role < ApplicationRecord
  validates :name, presence: true
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles
  has_many :role_privileges, dependent: :destroy
  has_many :proposal_roles, dependent: :destroy
end
