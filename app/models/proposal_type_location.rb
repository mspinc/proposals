class ProposalTypeLocation < ApplicationRecord
  belongs_to :proposal_type
  belongs_to :location
end
