class Api::V1::MoviesController < Api::V1::BaseController
  before_action :set_movie, only: :show
  before_action :authenticate_user!

  def create
    movie = Movie.create!(movie_params)
    render jsonapi: movie, status: :created
  end

  def show
    render jsonapi: @movie
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :poster_url, :average_rating, :release_date, :genre)
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end
end
