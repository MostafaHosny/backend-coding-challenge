# Movie Serializer
class MovieSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :poster_url, :release_date, :genre

  attribute :average_rating do |object|
    object.average_rating&.round(1)
  end
end
