class CreateAmsSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :ams_subjects do |t|
      t.string :code
      t.string :title
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
