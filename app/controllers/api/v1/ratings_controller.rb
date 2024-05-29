class Api::V1::RatingsController < ApplicationController
  before_action :authenticate_user, only: [:create]
  before_action :set_movie, only: [:create]

  def create
    rating = movive_rating_service.call
    if rating
      render jsonapi: rating, status: :created
    else
      render jsonapi_errors: movive_rating_service.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render jsonapi_errors: { error: 'Movie not found' }, status: :not_found
  end

  private

  def movive_rating_service
    @movive_rating_service ||= RatingService.new(@movie, @current_user, rating_params[:score])
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  # TODO: use real authentication using JWT
  def authenticate_user
    @current_user = User.first
  end

  def rating_params
    params.require(:rating).permit(:score)
  end
end
