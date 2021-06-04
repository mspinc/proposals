class AddColumnToProposalForm < ActiveRecord::Migration[6.1]
  def change
  	add_column :proposal_forms, :version, :integer, :default=>0
  end
end
