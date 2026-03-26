require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'メールアドレスとパスワードがあれば有効' do
      user = User.new(email: 'test@example.com', password: 'password')
      expect(user).to be_valid
    end

    it 'メールアドレスがなければ無効' do
      user = User.new(email: '', password: 'password')
      expect(user).not_to be_valid
    end

    it 'パスワードがなければ無効' do
      user = User.new(email: 'test@example.com', password: '')
      expect(user).not_to be_valid
    end

    it '重複するメールアドレスは無効' do
      User.create!(email: 'test@example.com', password: 'password')
      user = User.new(email: 'test@example.com', password: 'password')
      expect(user).not_to be_valid
    end
  end

  describe 'confirmable' do
    it '新規ユーザーは未確認状態' do
      user = User.create!(email: 'test@example.com', password: 'password')
      expect(user.confirmed?).to be false
    end

    it 'メール確認後は確認済みになる' do
      user = User.create!(email: 'test@example.com', password: 'password')
      user.confirm
      expect(user.confirmed?).to be true
    end
  end
end
