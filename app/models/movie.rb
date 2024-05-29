# Movie class
class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :genre, presence: true
  validates :release_date, presence: true
  validates :average_rating, numericality: { greater_than_or_equal_to: 0.0, less_than_or_equal_to: 10.00 }

  has_many :ratings, dependent: :destroy

  def update_average_rating
    update(average_rating: ratings.average(:score)&.round(1))
  end
end
