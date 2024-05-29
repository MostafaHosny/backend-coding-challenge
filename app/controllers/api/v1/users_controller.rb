class Api::V1::UsersController < Api::V1::BaseController
  before_action :load_user, only: :show
  before_action :authenticate_user!, only: %i[show profile]

  def create
    user = User.create!(user_params)

    render jsonapi: user, status: :created
  end

  def show
    render jsonapi: @user
  end

  def profile
    render jsonapi: @current_user, include: [:rated_movies]
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def load_user
    @user = User.find(params[:id])
  end
end
