class AddColumnToInvite < ActiveRecord::Migration[6.1]
  def change
    add_column :invites, :deadline_date, :datetime
  end
end
