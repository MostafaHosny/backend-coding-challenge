class RatingSerializer
  include JSONAPI::Serializer
  attributes :score

  belongs_to :user
  belongs_to :movie
end
