class CreateProposals < ActiveRecord::Migration[6.1]
  def change
    create_table :proposals do |t|
      t.references :location, null: false, foreign_key: true
      t.references :proposal_type, null: false, foreign_key: true
      t.jsonb :submission

      t.timestamps
    end
  end
end
