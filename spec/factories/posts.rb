FactoryBot.define do
  factory :post do
    author { Faker::Name.name }
    author_id { Faker::Number.non_zero_digit }
    likes { Faker::Number.within(range: 0..2000) }
    popularity { Faker::Number.within(range: 0.0..1.0) }
    reads { Faker::Number.within(range: 0..2000) }
    tags { [] }
  end
end
