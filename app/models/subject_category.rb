class SubjectCategory < ApplicationRecord
  validates :code, uniqueness: true
  validates :name, :code, presence: true
  has_many :subjects
end
