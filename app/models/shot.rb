class Shot < ActiveRecord::Base
  attr_accessible :reference, :type, :x_pos, :y_pos
  
  belongs_to :game
  
  validates_numericality_of :x_pos, :y_pos
  validates_presence_of :game_id
  validates_inclusion_of :type, in: %w[Goal Defended]
  validates_inclusion_of :x_pos, in: (1..4)
  validates_inclusion_of :y_pos, in: (1..4)
  validate :if_my_game_ended
    
  default_scope order("created_at ASC")
  def game_shots_count
    if self.game && self.game.shots
      return self.game.shots.count
    end
    return 0
  end
  
  private
    
  def if_my_game_ended
    if self.game_shots_count == 5
      errors[:base] << "Game ended, you can't throw again."
    end
  end
  
end
