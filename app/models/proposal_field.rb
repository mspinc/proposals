class ProposalField < ApplicationRecord
  belongs_to :proposal_form
  belongs_to :location, optional: true
end
