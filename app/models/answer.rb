class Answer < ApplicationRecord
  validates :answer, presence: true
  belongs_to :proposal_field
  belongs_to :proposal
end
