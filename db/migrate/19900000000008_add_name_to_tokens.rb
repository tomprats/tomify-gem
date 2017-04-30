class AddNameToTokens < ActiveRecord::Migration[5.0]
  def change
    add_column :tokens, :name, :string
    add_index :tokens, [:uuid, :name]
  end
end
