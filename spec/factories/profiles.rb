FactoryBot.define do
  factory :profile do
    association :user, factory: :user
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    info { Faker::Job.title } 
  end
end
