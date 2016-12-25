class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :location
      t.string :level
      t.text :intro
      t.string :equipment
      t.string :logo
      t.string :banner

      t.timestamps null: false
    end
  end
end
