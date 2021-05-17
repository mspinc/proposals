class AddStatusInProposal < ActiveRecord::Migration[6.1]
  def change
  	add_column :proposals, :status, :integer
  end
end
