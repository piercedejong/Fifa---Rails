class AddKnockoutToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :knockout, :boolean
  end
end
