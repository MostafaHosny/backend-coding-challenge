# Movie class
class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :genre, presence: true
  validates :release_date, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 0.0, less_than_or_equal_to: 5.0 }
end
