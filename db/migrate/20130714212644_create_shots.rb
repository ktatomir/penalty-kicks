class CreateShots < ActiveRecord::Migration
  def change
    create_table :shots do |t|
      t.string :type
      t.references :game
      t.integer :x_pos
      t.integer :y_pos
      t.timestamps
    end
    add_index :shots, :game_id
  end
end
