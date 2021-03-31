class BirsSubject < ApplicationRecord
  belongs_to :category
  has_many :ams_subjects, dependent: :destroy
end
