# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
for i in (1..100) do
  Movie.create!(
    title: "#{i}:" + Faker::Movie.title,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    poster_url: Faker::Internet.url,
    rating: Faker::Number.between(from: 1, to: 10),
    release_date: Faker::Date.between(from: '1950-01-01', to: '2023-12-31'),
    genre: Faker::Book.genre
  )
end
