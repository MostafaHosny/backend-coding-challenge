# rating_service_spec.rb

require 'rails_helper'

RSpec.describe RatingService, type: :service do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }

  describe '#call' do
    context 'with valid rating parameters' do
      let(:score) { 8 }
      let(:service) { described_class.new(movie, user, score) }

      it 'creates a new rating' do
        expect(service.call).to be true
        expect(Rating.count).to eq(1)
        expect(Rating.first.user).to eq(user)
        expect(Rating.first.score).to eq(score)
      end

      it 'updates the average_rating of the movie' do
        service.call
        expect(movie.reload.average_rating.to_f).to eq(score.to_f)
      end
    end

    context 'with an existing rating' do
      let!(:existing_rating) { create(:rating, movie:, user:, score: 5) }
      let(:score) { 9 }
      let(:service) { described_class.new(movie, user, score) }

      it 'updates an existing rating' do
        expect(service.call).to be true
        expect(Rating.count).to eq(1)
        expect(existing_rating.reload.score).to eq(score)
      end
    end

    context 'with invalid parameters' do
      let(:score) { 11 } # Outside valid range
      let(:service) { described_class.new(movie, user, score) }

      it 'does not create a rating' do
        expect(service.call).to be false
        expect(Rating.count).to eq(0)
        expect(service.errors.full_messages).to include('Score must be an integer between 1 and 10')
      end
    end
  end
end
