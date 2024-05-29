class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :name

  has_many :rated_movies, serializer: MovieSerializer
end
