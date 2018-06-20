class AddSingleToTeam < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :single, :boolean, :default => false
  end
end
