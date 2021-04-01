class Subject < ApplicationRecord
  belongs_to :subject_category
  has_many :ams_subjects
end
