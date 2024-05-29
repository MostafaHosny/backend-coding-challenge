# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true

  # relationships
  has_many :ratings, dependent: :destroy
  has_many :rated_movies, through: :ratings, source: :movie
end
