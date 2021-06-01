class CreateUserFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.string :content
      t.references :user

      t.timestamps
    end
  end
end
