class Game < ActiveRecord::Base
    attr_accessible :player_name, :scores

    has_many :shots, dependent: :destroy
    has_many :goals, dependent: :destroy
    has_many :defendeds, dependent: :destroy

    validates_numericality_of :scores

    default_scope order("scores DESC")

    scope :highscores, where("player_name is not NULL").limit(5)

    def defend
        return rand(1..4), rand(1..4)
    end

    def check_if_goal(server_vector, player_vector)
        points = self.scores
        shot = server_vector == player_vector ? self.shots.build(x_pos: player_vector[0], y_pos: player_vector[1]) :
            self.shots.build(x_pos: player_vector[0], y_pos: player_vector[1], score: 1)
        if shot.save
          self.update_attribute(:scores, points+shot.score)
        end
        shot
    end
end
