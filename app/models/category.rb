class Category < ApplicationRecord
  has_many :birs_subjects, dependent: :destroy
end
