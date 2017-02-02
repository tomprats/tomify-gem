class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.boolean :admin, default: false, null: false, index: true
      t.string  :email,                 null: false, index: true
      t.string  :first_name,            null: false
      t.string  :last_name,             null: false
      t.string  :password_digest

      t.timestamps                      null: false
    end
  end
end
