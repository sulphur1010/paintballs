class AddCityToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :city, :string
  end
end
