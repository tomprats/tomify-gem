class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.boolean :active, default: true, null: false, index: true
      t.string  :email,                 null: false, index: true

      t.timestamps                      null: false
      t.index [:active, :email]
    end
  end
end
