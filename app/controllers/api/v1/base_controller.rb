module API
  module V1
    class CustomValidationError < StandardError; end

    class BaseController < ApplicationController
      respond_to :json

      rescue_from CustomValidationError,
                  ActiveRecord::RecordNotSaved,
                  ActiveRecord::RecordNotUnique do |e|
        render json: { error_code: e.message }, status: 422
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        render json: e.record.errors.details.transform_values { |vs| vs.pluck(:error) }, status: 422
      end

      rescue_from ActionController::RoutingError,
                  ActiveRecord::RecordNotFound do
        render json: { error_code: :not_found }, status: 404
      end
    end
  end
end
