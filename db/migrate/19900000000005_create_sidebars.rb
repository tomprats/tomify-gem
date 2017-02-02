class CreateSidebars < ActiveRecord::Migration[5.0]
  def change
    create_table :sidebars do |t|
      t.boolean :active, default: false, null: false, index: true
      t.string  :name,                   null: false
      t.string  :heading
      t.text    :text

      t.timestamps                       null: false
    end
  end
end
