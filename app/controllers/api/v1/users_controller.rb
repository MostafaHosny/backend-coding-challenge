class Api::V1::UsersController < Api::V1::BaseController
  before_action :load_user, only: :show

  def create
    user = User.create!(user_params)

    render json: UserSerializer.new(user), status: :created
  end

  def show
    render json: UserSerializer.new(@user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def load_user
    @user = User.find(params[:id])
  end
end
