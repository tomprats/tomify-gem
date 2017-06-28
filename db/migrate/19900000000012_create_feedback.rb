class CreateFeedback < ActiveRecord::Migration[5.0]
  def change
    create_table :feedback do |t|
      t.string  :user_id
      t.string  :name,                     null: false
      t.string  :email,                    null: false
      t.string  :subject,                  null: false
      t.string  :message,                  null: false
      t.boolean :resolved, default: false, null: false, index: true

      t.timestamps
      t.index [:resolved, :created_at]
    end
  end
end
