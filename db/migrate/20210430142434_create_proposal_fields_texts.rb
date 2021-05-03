class CreateProposalFieldsTexts < ActiveRecord::Migration[6.1]
  def change
    create_table :proposal_fields_texts do |t|
      t.string :statement
      
      t.timestamps
    end
  end
end
