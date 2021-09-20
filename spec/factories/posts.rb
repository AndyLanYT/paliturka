FactoryBot.define do
  factory :post do
    association :user, factory: :user
    body { Faker::Game.title }
  end
end
