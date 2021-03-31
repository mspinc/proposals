class Location < ApplicationRecord
  has_many :proposal_type_locations, dependent: :destroy
  has_many :proposal_types, through: :proposal_type_locations
  has_many :proposals, dependent: :destroy
  has_many :proposal_fields, dependent: :destroy
end
