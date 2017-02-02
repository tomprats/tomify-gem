class CreateTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :tokens do |t|
      t.integer :user_id, null: false
      t.uuid    :uuid,    null: false

      t.timestamps        null: false
    end
  end
end
