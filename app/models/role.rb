class Role < ApplicationRecord
  validates :name, presence: true
  enum role_type: { staff_role: 0, applicant_role: 1 }

  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles
  has_many :role_privileges, dependent: :destroy
  has_many :proposal_roles, dependent: :destroy
end
