# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
20.times do
  Post.create!(
    author: Faker::Name.name,
    author_id: Faker::Number.non_zero_digit,
    likes: Faker::Number.within(range: 0..2000),
    popularity: Faker::Number.within(range: 0.0..1.0),
    reads: Faker::Number.within(range: 0..2000),
    tags: ["tech", "health", "sports", "news", "celebrities", "travel", "music", "food"].sample(2)
  )
end

posts = Post.all