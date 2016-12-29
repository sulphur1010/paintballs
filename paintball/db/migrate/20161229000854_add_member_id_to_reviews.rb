class AddMemberIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :member_id, :integer
  end
end
