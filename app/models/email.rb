class Email < ApplicationRecord
  validates :subject, :body, presence: true
  belongs_to :proposal
end
