class AmsSubject < ApplicationRecord
  validates :title, :code, presence: true
  belongs_to :subject
  has_many :proposal_ams_subjects, dependent: :destroy
  has_many :proposals, through: :proposal_ams_subjects
end
