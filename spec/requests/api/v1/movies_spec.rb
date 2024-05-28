require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :request do
  describe 'Create movies' do
    context 'with valid movie parameters' do
      let(:valid_attributes) { attributes_for(:movie) }

      it 'creates a new movie' do
        expect do
          json_post api_v1_movies_path, params: { movie: valid_attributes }
        end.to change(Movie, :count).by(1)

        expect(response).to have_http_status(:created)

        expect(json['data']['attributes']).to match(
          'title' => valid_attributes[:title],
          'description' => valid_attributes[:description],
          'rating' => valid_attributes[:rating]&.round(1).to_s,
          'poster_url' => valid_attributes[:poster_url],
          'genre' => valid_attributes[:genre],
          'release_date' => valid_attributes[:release_date].to_formatted_s(:iso8601)
        )
      end
    end

    context 'with invalid movie parameters' do
      let(:invalid_attributes) { { title: nil } }

      it 'does not create a new movie' do
        expect do
          json_post api_v1_movies_path, params: { movie: invalid_attributes }
        end.not_to change(Movie, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET Movie' do
    let(:movie) { create(:movie) }

    it 'renders a successful response' do
      json_get api_v1_movie_path movie.id
      expect(response).to be_successful
      expect(json['data']['id']).to eq(movie.id.to_s)
    end

    it 'renders a not found response' do
      json_get  api_v1_movie_path 'invalid_id'
      expect(response).to have_http_status(:not_found)
    end
  end
end
