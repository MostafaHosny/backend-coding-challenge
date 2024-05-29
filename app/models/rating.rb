class Rating < ApplicationRecord
  validates :score,
            numericality: { only_integer: true, greater_than_or_equal_to: 1,
                            less_than_or_equal_to: 10,
                            message: 'must be an integer between 1 and 10' }

  validates :user, presence: true
  validates :movie, presence: true
  validates :user_id, uniqueness: { scope: :movie_id } # Ensure uniqueness for user and movie combination

  belongs_to :user
  belongs_to :movie
end
