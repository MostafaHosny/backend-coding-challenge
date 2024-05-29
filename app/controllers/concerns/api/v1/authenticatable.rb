module Api::V1::Authenticatable
  extend ActiveSupport::Concern

  included do
    def authenticate_user!
      header = request.headers['Authorization']
      token = header.split(' ').last if header

      begin
        decoded = JsonWebToken.decode(token)
        @current_user = User.find(decoded[:user_id])
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end
  end
end
