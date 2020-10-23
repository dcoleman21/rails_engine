require 'faker'

FactoryBot.define do
  factory :item do
    name        { Faker::Space.star }
    description { Faker::Hipster.paragraph(sentence_count: 2) }
    unit_price  { Faker::Number.decimal(l_digits: 2) }
    merchant
  end
end
