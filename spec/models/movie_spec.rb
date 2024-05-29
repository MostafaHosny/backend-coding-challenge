require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe '#update_average_rating' do
    let(:movie) { create(:movie, average_rating: 0) }

    context 'with no ratings' do
      it 'keeps the average rating as nil' do
        movie.update_average_rating
        expect(movie.average_rating).to be_nil
      end
    end

    context 'with ratings' do
      before do
        create(:rating, movie:, score: 8)
        create(:rating, movie:, score: 9)
        create(:rating, movie:, score: 7)
      end

      it 'updates the average rating correctly' do
        movie.update_average_rating
        expect(movie.average_rating).to eq(8.0)
      end
    end
  end
end
