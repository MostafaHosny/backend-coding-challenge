# Movie Serializer
class MovieSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :poster_url, :release_date, :genre

  attribute :rating do |object|
    object.rating&.round(1)
  end
end
