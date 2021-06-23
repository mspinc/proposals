class ProposalRole < ApplicationRecord
  belongs_to :proposal
  belongs_to :role
  belongs_to :person

  def self.lead_organizer?(person_id)
  	return if where('person_id = ?', person_id).empty?

  	where('person_id = ?', person_id).map(&:role).map(&:name).include?('lead_organizer')
  end
end
