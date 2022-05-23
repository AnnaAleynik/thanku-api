FactoryBot.define do
  factory :bonus_transfer do
    sender factory: :employee
    receiver factory: :johann_sebastian_employee
    amount { 100 }
    comment { FFaker::Lorem.sentence }
  end
end
