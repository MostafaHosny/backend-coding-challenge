require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe 'POST' do
    context 'with valid parameters' do
      let(:valid_attributes) { FactoryBot.attributes_for(:user) }

      it 'creates a new user' do
        expect do
          post '/api/v1/users', params: { user: valid_attributes }
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { FactoryBot.attributes_for(:user, email: 'invalid_email') }

      it 'does not create a new user' do
        expect do
          post '/api/v1/users', params: { user: invalid_attributes }
        end.to_not change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['errors']).to include('Email is invalid')
      end
    end
  end

  describe 'GET /api/v1/users/:id' do
    let(:user) { create(:user) }

    it 'renders a successful response' do
      get "/api/v1/users/#{user.id}"
      expect(response).to be_successful
      expect(json['id']).to eq(user.id)
      expect(json['name']).to eq(user.name)
      expect(json['email']).to eq(user.email)
    end

    it 'renders a not found response' do
      get '/api/v1/users/invalid_id'
      expect(response).to have_http_status(:not_found)
      expect(json['error']).to eq('User not found')
    end
  end
end
