class ProposalForm < ApplicationRecord
  validates :title, presence: true
  belongs_to :proposal_type
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
  has_many :proposal_fields, -> { order(position: :asc) }, dependent: :destroy
  enum status: { draft: 0, active: 1 }
  scope :active_form, -> (id) { where(proposal_type_id: id, status: :active)&.last }

  def created_on
    created_at.strftime('%Y-%m-%d %H:%M %Z')
  end

  def updated_on
    updated_at.strftime('%Y-%m-%d %H:%M %Z')
  end

  def updated?
    updated_at > created_at
  end
end
