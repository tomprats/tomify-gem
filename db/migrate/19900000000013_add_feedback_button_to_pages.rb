class AddFeedbackButtonToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :feedback, :boolean, default: true, null: false
  end
end
