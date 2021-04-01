class Subject < ApplicationRecord
  validates_uniqueness_of :code
  
  belongs_to :subject_category
  has_many :ams_subjects
end
