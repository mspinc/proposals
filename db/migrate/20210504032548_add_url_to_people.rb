class AddUrlToPeople < ActiveRecord::Migration[6.1]
  def change
    change_table :people do |t|
      t.string :url
    end
  end
end
