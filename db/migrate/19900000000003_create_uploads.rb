class CreateUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :uploads do |t|
      t.string :uuid,         null: false, index: true
      t.string :name,         null: false, index: true
      t.string :file,         null: false
      t.string :size,         null: false
      t.string :content_type, null: false

      t.timestamps            null: false
    end
  end
end
