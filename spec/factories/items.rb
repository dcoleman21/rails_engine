FactoryBot.define do
  factory :item do
    merchant  
    name        { Faker::Space.star }
    description { Faker::Lorem.sentence }
    unit_price  { Faker::Commerce.price }
  end
end
