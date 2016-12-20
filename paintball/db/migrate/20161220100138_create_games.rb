class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.string :image
      t.text :description
      t.string :slug

      t.timestamps null: false
    end
  end
end
