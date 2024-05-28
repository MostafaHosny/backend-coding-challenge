# frozen_string_literal: true

# Base controller for API/V1 to handle common errors
class Api::V1::BaseController < ApplicationController
  respond_to :json

  rescue_from ActiveRecord::RecordNotSaved,
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
