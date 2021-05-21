class Validation < ApplicationRecord
  belongs_to :proposal_field
  enum validation_type: { mandatory: 0, include: 1, equal: 2, greater: 3, less: 4 } 
end
