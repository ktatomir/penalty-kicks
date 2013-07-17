class AddScoreToShot < ActiveRecord::Migration
  def change
    add_column :shots, :score, :integer, default: 0
    remove_column :shots, :type
  end
end
