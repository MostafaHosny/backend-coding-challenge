class AddUniqueIndexToRatings < ActiveRecord::Migration[7.1]
  def change
    add_index :ratings, %i[user_id movie_id], unique: true
  end
end
