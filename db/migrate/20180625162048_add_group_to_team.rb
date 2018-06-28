class AddGroupToTeam < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :group, :string
  end
end
