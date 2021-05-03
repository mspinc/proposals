class AddIndexAndDescriptionInProposalField < ActiveRecord::Migration[6.1]
  def change
  	add_column :proposal_fields, :index, :integer
  	add_column :proposal_fields, :description, :text
  end
end
