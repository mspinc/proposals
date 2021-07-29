class CreateBirsDiscussion < ActiveRecord::Migration[6.1]
  def change
    create_table :birs_discussions do |t|
      t.text :discussion

      t.references :proposal, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
