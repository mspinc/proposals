class Faq < ApplicationRecord
  validates :question, :answer, presence: true
  acts_as_list
  default_scope { order(position: :asc) }
end
