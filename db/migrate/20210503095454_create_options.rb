class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options do |t|
      t.string :text
      t.references :optionable, polymorphic: true

      t.timestamps
    end
  end
end
