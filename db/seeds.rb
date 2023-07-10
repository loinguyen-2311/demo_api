# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


p "Seeding 20 books"
20.times do ||
  Book.create! title: Faker::Book.title, author: Faker::Book.author, image: Faker::Avatar.image
end

p "Seeding 10 users"
10.times do |n|
  User.create! email: Faker::Internet.email, password: 'test_user'
end

p "Seeding 100 reviews"
user_ids = User.pluck(:id)
book_ids = Book.pluck(:id)
100.times do |n|
  Review.create! title:  'best book ever',
                 content_rating: Faker::Number.between(from: 1, to: 10),
                 recommend_rating: Faker::Number.between(from: 1, to: 10),
                 user_id: user_ids.sample,
                 book_id: book_ids.sample
end