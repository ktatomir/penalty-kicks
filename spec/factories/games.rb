# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    sequence(:player_name) { |n| "Player_#{n}" }
    scores 0
  end
end
