require 'spec_helper'

require 'spec_helper'

describe Game do
  it { should have_many(:shots).dependent(:destroy) }
  it { should allow_value(nil).for(:player_name) }
  it { should validate_numericality_of(:scores) }
  
  before(:each) do
    @game = create :game
  end
  
  it "draw a defending position" do
    x, y = @game.defend
    x.should_not be_nil
    y.should_not be_nil
  end
  
  it "compares positions, if they not match save as Goal" do
    x, y = @game.defend
    player_pos = [x%3+1, y%3+1]
    shot = @game.check_if_goal([x, y], player_pos)
    shot.score.should eq(1)
    shot.x_pos.should eq(player_pos[0])
    shot.y_pos.should eq(player_pos[1])
  end
  
  it "should increase scores if goal" do
    x, y = @game.defend
    scores = @game.scores
    player_pos = [x%3+1, y%3+1]
    goal = @game.check_if_goal([x, y], player_pos)
    @game.scores.should eq(scores+1)
  end
  
  it "compares positions, if they match save as Defended" do
    x, y = @game.defend
    x_pos, y_pos = x, y
    shot = @game.check_if_goal([x, y], [x_pos, y_pos])
    shot.score.should eq(0)
  end
  
end

