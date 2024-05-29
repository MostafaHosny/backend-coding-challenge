class RatingService
  attr_reader :errors

  def initialize(movie, user, score)
    @movie = movie
    @user = user
    @score = score
    @errors = []
  end

  def call
    rating = find_or_build_rating
    rating.score = @score
    return false unless rating_valid?(rating)

    rating.save && update_average_rating
  end

  private

  # TODO: change this to call a background job using Sidekiq and redis
  # so it dose not affect the write capcity
  def update_average_rating
    @movie.update_average_rating
  end

  def find_or_build_rating
    Rating.find_or_initialize_by(user: @user, movie: @movie)
  end

  def rating_valid?(rating)
    unless rating.valid?
      @errors = rating.errors
      return false
    end

    true
  end
end
