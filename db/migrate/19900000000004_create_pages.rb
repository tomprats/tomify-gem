class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.integer :parent_id,                           index: true
      t.integer :sidebar_id
      t.boolean :active, default: false, null: false, index: true
      t.boolean :root,   default: false, null: false, index: true
      t.integer :rank,   default: 100,   null: false, index: true
      t.string  :path,                   null: false, index: true
      t.string  :name,                   null: false
      t.string  :template,               null: false
      t.string  :title
      t.string  :description
      t.string  :cover_image
      t.string  :share_image
      t.text    :text

      t.timestamps                       null: false
      t.index [:active, :rank]
    end
  end
end
