class Shot < ActiveRecord::Base
  attr_accessible :reference, :type, :x_pos, :y_pos
  
  belongs_to :game
end
