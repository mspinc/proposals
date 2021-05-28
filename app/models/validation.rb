class Validation < ApplicationRecord
  belongs_to :proposal_field
  enum validation_type: { mandatory: 0 } 
end
