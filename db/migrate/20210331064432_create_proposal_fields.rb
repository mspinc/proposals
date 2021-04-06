class CreateProposalFields < ActiveRecord::Migration[6.1]
  def change
    create_table :proposal_fields do |t|
      t.string :type
      t.string :statement
      t.references :proposal_form, null: false, foreign_key: true
      t.integer :location_id

      t.timestamps
    end
  end
end
