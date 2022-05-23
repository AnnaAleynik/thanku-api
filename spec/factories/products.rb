FactoryBot.define do
  factory :product do
    company
    name { FFaker::Product.product_name }
    description { FFaker::Lorem.sentence }
    count { 10 }
    price { 100 }
  end
end
