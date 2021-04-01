class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.string :code
      t.string :title
      t.references :subject_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
