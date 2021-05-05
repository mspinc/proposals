class AddOptionsInRadioTypeField < ActiveRecord::Migration[6.1]
  def change
  	add_column :proposal_fields_radios, :options, :jsonb, default: '{}'
  end
end
