class ProposalRole < ApplicationRecord
  belongs_to :proposal
  belongs_to :role
  belongs_to :person
end
