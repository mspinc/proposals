class ProposalRole < ApplicationRecord
  belongs_to :proposal
  belongs_to :role
end
