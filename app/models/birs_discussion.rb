class BirsDiscussion < ApplicationRecord
  validates :discussion, presence: true

  belongs_to :proposal
end
