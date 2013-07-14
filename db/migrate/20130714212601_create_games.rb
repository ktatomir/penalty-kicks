class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :player_name
      t.integer :scores, default: 0
      t.timestamps
    end
  end
end
