class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.integer :trackable_id,   null: false
      t.string  :trackable_type, null: false
      t.string  :action,         null: false
      t.string  :controller,     null: false

      t.timestamps               null: false
      t.index [:trackable_id, :trackable_type]
      t.index [:action, :controller]
    end
  end
end
