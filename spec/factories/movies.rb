FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    poster_url { Faker::Internet.url(host: 'placeimg.com', path: '/1000/1500/any') }
    rating { Faker::Number.between(from: 1.0, to: 5.0) }
    release_date { Faker::Date.between(from: '1950-01-01', to: '2023-12-31') }
    genre { Faker::Book.genre }
  end
end
