class CreateProposalForms < ActiveRecord::Migration[6.1]
  def change
    create_table :proposal_forms do |t|
      t.integer :status
      t.references :proposal_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
