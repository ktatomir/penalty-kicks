# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shot do
    game
    score 0
    sequence(:x_pos) {|n| rand(1..4) }
    sequence(:y_pos) {|n| rand(1..4) }
  end
end
