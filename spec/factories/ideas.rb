FactoryBot.define do
  factory :idea do
    sequence(:title) { |n| "#{Faker::Cannabis.strain}-#{n}" }
    body { Faker::Cannabis.health_benefit }
  end
end
