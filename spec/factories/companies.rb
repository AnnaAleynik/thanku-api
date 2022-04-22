FactoryBot.define do
  factory :company do
    name { "#{FFaker::Company.name}#{rand(1..100)}" }
    description { FFaker::Company.catch_phrase }
    bonus_amount { rand(1..10) * 100 }
  end
end
