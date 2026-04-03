require 'rails_helper'

RSpec.describe "Users::Confirmations", type: :request do
  let(:user) do
    User.create!(
      email: 'confirm-me@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
  end

  describe "GET /users/confirmation" do
    it "有効なトークンでメール確認を完了できる" do
      get user_confirmation_path, params: { confirmation_token: user.confirmation_token }

      expect(response).to have_http_status(:found)
      expect(user.reload).to be_confirmed

      post user_session_path, params: {
        user: {
          email: user.email,
          password: 'password123'
        }
      }

      get root_path
      expect(response.body).to include(user.email)
    end

    it "無効なトークンでは未確認のままになる" do
      get user_confirmation_path, params: { confirmation_token: 'invalid-token' }

      expect(response).to have_http_status(:ok)
      expect(user.reload).not_to be_confirmed
    end
  end
end
