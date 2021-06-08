class Subject < ApplicationRecord
  validates :code, uniqueness: true
  validates :title, :code, presence: true

  belongs_to :subject_category
  has_many :proposals, dependent: :destroy
  has_many :ams_subjects, dependent: :destroy
end
