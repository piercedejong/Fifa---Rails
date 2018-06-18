class AddValueToTeam < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :value, :integer
  end
end
