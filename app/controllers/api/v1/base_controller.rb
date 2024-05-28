# frozen_string_literal: true

# Base controller for API/V1 to handle common errors
class Api::V1::BaseController < ApplicationController
  include JSONAPI::Errors

  rescue_from ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique do |e|
    render jsonapi_errors: e.record.errors, status: :unprocessable_entity
  end

  rescue_from ActionController::RoutingError, ActiveRecord::RecordNotFound do |e|
    render status: :not_found
  end
end
