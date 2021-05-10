class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.references :proposal_field, null: false, foreign_key: true
      t.references :proposal, null: false, foreign_key: true
      t.string :answer
      
      t.timestamps
    end
  end
end
