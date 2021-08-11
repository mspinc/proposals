class SubjectCategory < ApplicationRecord
  validates :code, uniqueness: true, presence: true
  validates :name, presence: true
  has_many :subjects
end
