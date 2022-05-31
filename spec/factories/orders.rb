FactoryBot.define do
  factory :order do
    price { 100 }
    quantity { 1 }
    comment { "Violet" }
    product
    user
  end
end
