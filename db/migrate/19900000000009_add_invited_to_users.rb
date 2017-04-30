class AddInvitedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :invited, :boolean, default: false, null: false
  end
end
