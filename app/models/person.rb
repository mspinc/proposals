class Person < ApplicationRecord
  attr_accessor :is_lead_organizer

  validates :firstname, :lastname, :email, presence: true
  belongs_to :user, optional: true
  has_many :proposal_roles, dependent: :destroy
  has_many :proposals, through: :proposal_roles
  has_one :demographic_data, dependent: :destroy

  def fullname
    "#{firstname} #{lastname}"
  end

  validate :lead_organizer_attributes, if: :is_lead_organizer, on: :update
  validate :common_fields, on: :update

  def lead_organizer_attributes
    errors.add('Street 1', "can't be blank") if street_1.blank?
    errors.add('City', "can't be blank") if city.blank?
  end

  def common_fields
    errors.add('Main Affiliation/Institution', "can't be blank") if affiliation.blank?
    errors.add('Academic Status', "can't be blank") if academic_status.blank?
    errors.add('Year of First Phd', "can't be blank") if first_phd_year.blank?
    errors.add('Country', "can't be blank") if country.blank?

    return unless country == 'Canada' || country == 'United States of America' && region.blank?

    errors.add('Region', "can't be blank")
  end
end
