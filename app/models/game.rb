class Game < ActiveRecord::Base
  attr_accessible :player_name, :scores
  
  has_many :shots
  has_many :goals
  has_many :defended
end
