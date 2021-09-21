FactoryBot.define do
  factory :confirmed_user, parent: :user do
    after(:create, &:confirm)
  end
end
