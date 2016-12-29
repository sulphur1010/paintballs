class AddGameIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :game_id, :integer
  end
end
