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
        Rails.logger.error "Api::V1::Authenticatable error: #{e.message}"
        render json: { errors: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
