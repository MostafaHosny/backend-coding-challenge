class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :poster_url
      t.decimal :average_rating, precision: 3, scale: 1, default: 0.0
      t.string :genre
      t.date :release_date

      t.timestamps
    end
  end
end
