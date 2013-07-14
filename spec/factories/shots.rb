# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shot do
    game
    sequence(:type) {|n| ['Goal', 'Defended'].sample }
    sequence(:x_pos) {|n| rand(1..4) }
    sequence(:y_pos) {|n| rand(1..4) }
  end
end
