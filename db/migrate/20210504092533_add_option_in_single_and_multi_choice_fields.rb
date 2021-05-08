class AddOptionInSingleAndMultiChoiceFields < ActiveRecord::Migration[6.1]
  def change
  	add_column :proposal_fields_single_choices, :options, :jsonb, default: '{}'
  	add_column :proposal_fields_multi_choices, :options, :jsonb, default: '{}'
  end
end
