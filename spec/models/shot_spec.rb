require 'spec_helper'

describe Shot do
  it { should belong_to(:game) }
  it { should ensure_inclusion_of(:type).in_array(%w[Goal Defended]) }
  it { should validate_numericality_of(:x_pos) }
  it { should validate_numericality_of(:y_pos) }
  it { should ensure_inclusion_of(:x_pos).in_range(1..4) }
  it { should ensure_inclusion_of(:y_pos).in_range(1..4) }
  it { should validate_presence_of(:game_id) }
  
  it "can not be saved if it's game has 5 shots already" do
    @game = FactoryGirl.create(:game)
    5.times do
      FactoryGirl.create(:shot, game_id: @game.id)
    end
    extra_shot = FactoryGirl.build(:shot, game_id: @game.id)
    extra_shot.should_not be_valid
  end
end
