class Answer < ApplicationRecord
  belongs_to :proposal_field
  belongs_to :proposal
  has_one_attached :file
end
