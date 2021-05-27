class Person < ApplicationRecord
  validates :firstname, :lastname, :email, presence: true
  belongs_to :user, optional: true
  has_many :proposal_roles, dependent: :destroy
  has_many :proposals, through: :proposal_roles


  def fullname
    firstname + ' ' + lastname
  end
end
