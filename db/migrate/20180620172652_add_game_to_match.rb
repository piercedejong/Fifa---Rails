class AddGameToMatch < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :game, :string
  end
end
