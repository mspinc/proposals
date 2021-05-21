class CreateValidations < ActiveRecord::Migration[6.1]
  def change
    create_table :validations do |t|
      t.integer :validation_type
      t.string :value
      t.string :error_message
      t.references :proposal_field

      t.timestamps
    end
  end
end
