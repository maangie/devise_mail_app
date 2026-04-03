require 'cgi'
require 'rails_helper'

RSpec.describe "Users::Passwords", type: :request do
  let(:user) do
    record = User.create!(
      email: 'reset-me@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
    record.confirm
    record
  end

  def raw_reset_password_token
    body = ActionMailer::Base.deliveries.last.body.encoded
    CGI.unescape(body.match(/reset_password_token=([^"&]+)/)[1])
  end

  describe "POST /users/password" do
    before do
      user
      ActionMailer::Base.deliveries.clear
    end

    it "再設定メールを送信する" do
      expect {
        post user_password_path, params: { user: { email: user.email } }
      }.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(user.reload.reset_password_token).to be_present
      expect(response).to have_http_status(:see_other)
    end
  end

  describe "PUT /users/password" do
    before do
      ActionMailer::Base.deliveries.clear
      user.send_reset_password_instructions
    end

    it "再設定トークンでパスワードを更新できる" do
      put user_password_path, params: {
        user: {
          reset_password_token: raw_reset_password_token,
          password: 'new-password123',
          password_confirmation: 'new-password123'
        }
      }

      expect(response).to have_http_status(:see_other)
      expect(user.reload.valid_password?('new-password123')).to be true
    end

    it "更新後は新しいパスワードでログインできる" do
      put user_password_path, params: {
        user: {
          reset_password_token: raw_reset_password_token,
          password: 'new-password123',
          password_confirmation: 'new-password123'
        }
      }

      delete destroy_user_session_path

      post user_session_path, params: {
        user: {
          email: user.email,
          password: 'new-password123'
        }
      }

      get root_path
      expect(response.body).to include(user.email)
    end
  end
end
