class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|
      t.boolean :public, default: true, null: false, index: true
      t.string  :type,                  null: false, index: true
      t.string  :name,                  null: false, index: true
      t.string  :value
      t.json    :json,   default: {},   null: false

      t.timestamps                      null: false
    end
  end
end
