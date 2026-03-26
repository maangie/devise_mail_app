require 'rails_helper'

RSpec.describe "Users::Registrations", type: :request do
  include Warden::Test::Helpers

  after { Warden.test_reset! }

  let(:user) do
    u = User.create!(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')
    u.confirm
    u
  end

  describe "DELETE /users (アカウント削除)" do
    context "ログイン済みユーザーの場合" do
      before { login_as user, scope: :user }

      it "自分のアカウントを削除できる（リダイレクトされる）" do
        delete user_registration_path
        expect(response).to have_http_status(:see_other)
      end

      it "DBからユーザーレコードが削除される" do
        user_id = user.id
        delete user_registration_path
        expect(User.exists?(user_id)).to be false
      end

      it "削除後はトップページへリダイレクトされる" do
        delete user_registration_path
        expect(response).to redirect_to(root_path)
      end

      it "削除後にログインしようとしても失敗する" do
        email = user.email
        delete user_registration_path
        post user_session_path, params: { user: { email: email, password: 'password123' } }
        expect(response).not_to redirect_to(root_path)
      end
    end

    context "未ログインの場合" do
      it "削除できずサインインページへリダイレクトされる" do
        delete user_registration_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
