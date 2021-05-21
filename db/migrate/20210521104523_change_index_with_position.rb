class ChangeIndexWithPosition < ActiveRecord::Migration[6.1]
  def change
  	rename_column :proposal_fields, :index, :position
  end
end
