class AddEveryoneToTeam < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :everyone, :boolean, :default => false 
  end
end
