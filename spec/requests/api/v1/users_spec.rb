require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe 'POST Users' do
    context 'with valid parameters' do
      let(:valid_attributes) { attributes_for(:user) }

      it 'creates a new user' do
        expect do
          json_post api_v1_users_path, params: { user: valid_attributes }
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid email' do
      let(:invalid_attributes) { attributes_for(:user, email: 'invalid_email') }

      it 'does not create a new user' do
        expect do
          json_post api_v1_users_path, params: { user: invalid_attributes }
        end.to_not change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with no name provided' do
      let(:invalid_attributes) { attributes_for(:user, name: nil) }

      it 'does not create a new user' do
        expect do
          json_post api_v1_users_path, params: { user: invalid_attributes }
        end.to_not change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET user' do
    let(:user) { create(:user) }

    it 'renders a successful response' do
      json_get api_v1_user_path(user.id), auth_user: user
      expect(response).to be_successful
      expect(json['data']['id']).to eq(user.id.to_s)
    end

    it 'renders a not found response' do
      json_get api_v1_user_path 'invalid_id'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'User Profile' do
    let(:user) { create(:user) }
    context 'when user is authorized' do
      let!(:rated_movies) { create_list(:movie, 3) }
      before do
        rated_movies.each do |movie|
          create(:rating, user:, movie:)
        end
      end

      it 'renders a successful response with rated movies' do
        json_get api_v1_profile_path, auth_user: user
        expect(response).to be_successful
        expect(json['data']['relationships']['rated_movies']['data'].size).to eq(3)
        rated_movie_ids = json['data']['relationships']['rated_movies']['data'].map { |movie| movie['id'].to_i }
        expect(rated_movie_ids).to match_array(rated_movies.map(&:id))
      end
    end

    context 'when user unauthorized' do
      it 'renders unauthorized status' do
        json_get api_v1_profile_path
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
