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
      json_get api_v1_user_path user.id
      expect(response).to be_successful
      expect(json['data']['id']).to eq(user.id.to_s)
    end

    it 'renders a not found response' do
      json_get api_v1_user_path 'invalid_id'
      expect(response).to have_http_status(:not_found)
    end
  end
end
