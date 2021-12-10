FactoryBot.define do
  factory :post do
    author { "MyString" }
    author_id { 1 }
    likes { 1 }
    popularity { 1.5 }
    reads { 1 }
    tags { "MyString" }
  end
end
