require 'rails_helper'

RSpec.describe "Users::Sessions", type: :request do
  let(:confirmed_user) do
    user = User.create!(
      email: 'confirmed@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
    user.confirm
    user
  end

  let(:unconfirmed_user) do
    User.create!(
      email: 'unconfirmed@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
  end

  describe "POST /users/sign_in" do
    it "確認済みユーザーはログインできる" do
      post user_session_path, params: {
        user: {
          email: confirmed_user.email,
          password: 'password123'
        }
      }

      expect(response).to have_http_status(:see_other)

      get root_path
      expect(response.body).to include(confirmed_user.email)
    end

    it "未確認ユーザーはログインできない" do
      post user_session_path, params: {
        user: {
          email: unconfirmed_user.email,
          password: 'password123'
        }
      }

      expect(response).to redirect_to(new_user_session_path)

      get root_path
      expect(response.body).not_to include(unconfirmed_user.email)
    end
  end

  describe "DELETE /users/sign_out" do
    it "ログアウトするとセッションが破棄される" do
      post user_session_path, params: {
        user: {
          email: confirmed_user.email,
          password: 'password123'
        }
      }

      delete destroy_user_session_path

      expect(response).to redirect_to(root_path)

      get root_path
      expect(response.body).not_to include(confirmed_user.email)
      expect(response.body).to include('ログイン')
    end
  end
end
