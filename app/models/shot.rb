class Shot < ActiveRecord::Base
  attr_accessible :reference, :type, :x_pos, :y_pos
  before_validation :if_my_game_ended
  
  belongs_to :game
  
  validates_numericality_of :x_pos, :y_pos
  validates_presence_of :game_id
  validates_inclusion_of :type, in: %w[Goal Defended]
  validates_inclusion_of :x_pos, in: (1..4)
  validates_inclusion_of :y_pos, in: (1..4)
    
  default_scope order("created_at ASC")
  
  private
  
  def check_if_goal(server_vector, player_vector)
      points = self.game.scores
      shot = server_vector == player_vector ? self.defendeds.build(x_pos: player_vector[0], y_pos: player_vector[1]) : 
        self.goals.build(x_pos: player_vector[0], y_pos: player_vector[1])
      shot.save
      self.game.update_attribute(:scores, points+1) if shot.class.name == "Goal"
      shot
  end
  
  def if_my_game_ended
    if self.game.shots.count == 5
      errors[:base] << "Game ended, you can't throw again."
    end
  end
  
end
