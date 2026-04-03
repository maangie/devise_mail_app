require 'cgi'
require 'rails_helper'

RSpec.describe "Authentication flows", type: :system do
  def raw_reset_password_token
    body = ActionMailer::Base.deliveries.last.body.encoded
    CGI.unescape(body.match(/reset_password_token=([^"&]+)/)[1])
  end

  it "allows a visitor to sign up, confirm the account, sign in, and sign out" do
    ActionMailer::Base.deliveries.clear

    visit '/'
    within('nav') do
      click_link '新規登録'
    end
    fill_in 'user_email', with: 'system-user@example.com'
    fill_in 'user_password', with: 'password123'
    fill_in 'user_password_confirmation', with: 'password123'
    click_button '登録する'

    user = User.find_by!(email: 'system-user@example.com')
    expect(user).not_to be_confirmed
    expect(ActionMailer::Base.deliveries.count).to eq(1)

    visit "/users/confirmation?confirmation_token=#{CGI.escape(user.confirmation_token)}"
    expect(user.reload).to be_confirmed

    visit '/'
    within('nav') do
      click_link 'ログイン'
    end
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'password123'
    click_button 'ログイン'

    expect(page).to have_text(user.email)

    within('nav') do
      click_button 'ログアウト'
    end
    expect(page).to have_link('ログイン')
    expect(page).to have_link('新規登録')
  end

  it "lets a confirmed user reset the password and sign in with the new password" do
    user = User.create!(
      email: 'reset-system@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
    user.confirm
    ActionMailer::Base.deliveries.clear

    visit '/'
    within('nav') do
      click_link 'ログイン'
    end
    click_link 'パスワードをお忘れですか？'
    fill_in 'user_email', with: user.email
    click_button 'パスワード再設定メールを送信'

    expect(ActionMailer::Base.deliveries.count).to eq(1)

    visit "/users/password/edit?reset_password_token=#{CGI.escape(raw_reset_password_token)}"
    fill_in 'user_password', with: 'new-password123'
    fill_in 'user_password_confirmation', with: 'new-password123'
    click_button 'パスワードを変更する'

    expect(page).to have_text(user.email)

    within('nav') do
      click_button 'ログアウト'
    end
    within('nav') do
      click_link 'ログイン'
    end
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'new-password123'
    click_button 'ログイン'

    expect(page).to have_text(user.email)
  end
end
