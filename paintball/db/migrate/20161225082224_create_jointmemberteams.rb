class CreateJointmemberteams < ActiveRecord::Migration
  def change
    create_table :jointmemberteams do |t|
      t.references :member, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true
      t.integer :status

      t.timestamps null: false
    end
  end
end
