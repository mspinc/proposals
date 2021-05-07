class DropOrganizers < ActiveRecord::Migration[6.1]
  def change
    drop_table :organizers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :proposal, null: false, foreign_key: true
      t.integer :organizer_type

      t.timestamps
    end
  end
end
