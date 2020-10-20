FactoryBot.define do
  factory :item do
    name        { Faker::Space.star }
    description { Faker::Lorem.sentence }
    unit_price  { Faker::Commerce.price }
  end
end
