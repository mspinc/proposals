class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :affiliation
      t.jsonb :subject
      t.jsonb :areas_of_expertise
      t.text :biography
      t.boolean :deceased
      t.boolean :retired
      t.timestamps
    end
  end
end
