FactoryBot.define do
  factory :comment do
    association :user, factory: :user
    association :post, factory: :post
    body { Faker::Game.title }
  end
end
