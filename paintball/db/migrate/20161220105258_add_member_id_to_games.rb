class AddMemberIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :member_id, :integer
  end
end
