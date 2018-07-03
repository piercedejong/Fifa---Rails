class AddKnockoutToTeam < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :knockout, :boolean, :default => false
  end
end
