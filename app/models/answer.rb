class Answer < ApplicationRecord
  belongs_to :proposal_field
  belongs_to :proposal
end
