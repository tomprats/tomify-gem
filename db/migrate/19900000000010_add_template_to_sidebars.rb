class AddTemplateToSidebars < ActiveRecord::Migration[5.0]
  def change
    add_column :sidebars, :template, :string, null: false
  end
end
