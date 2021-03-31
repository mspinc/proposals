class CreateBirsSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :birs_subjects do |t|
      t.string :code
      t.string :title
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
