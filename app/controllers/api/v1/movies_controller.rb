class Api::V1::MoviesController < ApplicationController
  before_action :find_movie, only: :show

  def create
    movie = Movie.create!(movie_params)
    render jsonapi: movie, status: :created
  end

  def show
    render jsonapi: @movie
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :poster_url, :rating, :release_date, :genre)
  end

  def find_movie
    @movie = Movie.find(params[:id])
  end
end
