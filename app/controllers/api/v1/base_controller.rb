# frozen_string_literal: true

# Base controller for API/V1 to handle common errors
class Api::V1::BaseController < ApplicationController
  include JSONAPI::Errors
  include Api::V1::Authenticatable

  rescue_from ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique do |e|
    Rails.logger.error "Api::V1::BaseController: #{e.message}"
    render jsonapi_errors: e.record.errors, status: :unprocessable_entity
  end
end
