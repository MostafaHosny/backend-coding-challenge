require 'rails_helper'

require 'rails_helper'

RSpec.describe Api::V1::RatingsController, type: :request do
  describe 'Create movie ratings' do
    let!(:user) { create(:user) }
    let(:movie) { create(:movie) }

    context 'with valid parameters' do
      let(:valid_attributes) { { score: 8 } }

      it 'creates a new rating' do
        json_post "/api/v1/movies/#{movie.id}/ratings",
                  params: { rating: valid_attributes }

        expect(response).to have_http_status(:created)
        expect(json['data']['attributes']['score']).to eq(valid_attributes[:score])
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { score: 11 } } # score is not valid

      it 'returns an error message' do
        json_post "/api/v1/movies/#{movie.id}/ratings",
                  params: { rating: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['errors']).to_not be_empty
      end
    end

    context 'when movie does not exist' do
      it 'returns a not found error' do
        json_post('/api/v1/movies/invalid_id/ratings', params: { rating: { score: 8 } })
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
