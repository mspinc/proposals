class ChangePersonColumnNames < ActiveRecord::Migration[6.1]
  def change
    rename_column :people, :first_name, :firstname
    rename_column :people, :last_name, :lastname
    rename_column :people, :areas_of_expertise, :research_areas
  end
end
