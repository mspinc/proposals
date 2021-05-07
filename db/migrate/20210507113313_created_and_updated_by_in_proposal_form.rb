class CreatedAndUpdatedByInProposalForm < ActiveRecord::Migration[6.1]
  def change
    add_reference :proposal_forms, :created_by, foreign_key: { to_table: :users }
    add_reference :proposal_forms, :updated_by, foreign_key: { to_table: :users }
  end
end
