class CreateProposalRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :proposal_roles do |t|
      t.references :proposal, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
