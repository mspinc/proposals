class ProposalFieldPolymorphic < ActiveRecord::Migration[6.1]
  def change
  	remove_column :proposal_fields, :type, :string
  	add_column :proposal_fields, :fieldable_id, :bigint
  	add_column :proposal_fields, :fieldable_type, :string
  	add_index :proposal_fields, [:fieldable_type, :fieldable_id]
  end
end
