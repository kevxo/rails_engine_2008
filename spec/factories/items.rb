FactoryBot.define do
  factory :item do
    name { Faker::Camera.model }
    description { "Amazing" }
    unit_price { 20.00 }
    merchant
  end
end
