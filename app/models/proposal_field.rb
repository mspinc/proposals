class ProposalField < ApplicationRecord
  validates :statement, presence: true
  belongs_to :proposal_form
  belongs_to :location, optional: true
  belongs_to :fieldable, polymorphic: true
  has_one :answer, dependent: :destroy
  acts_as_list scope: :proposal_form
  has_many :validations, dependent: :destroy

  accepts_nested_attributes_for :validations, reject_if: :all_blank, allow_destroy: true
  FIELD_TYPES = %w[Date Radio Text SingleChoice MultiChoice].freeze
end
