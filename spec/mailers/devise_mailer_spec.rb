require 'rails_helper'

RSpec.describe Devise::Mailer, type: :mailer do
  describe '確認メール' do
    let!(:user) { User.create!(email: 'test@example.com', password: 'password') }

    before { ActionMailer::Base.deliveries.clear }

    it '確認メールが送信される' do
      expect {
        user.send_confirmation_instructions
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it '確認メールの宛先が正しい' do
      user.send_confirmation_instructions
      mail = ActionMailer::Base.deliveries.last
      expect(mail.to).to include('test@example.com')
    end

    it '確認メールの送信元が正しい' do
      user.send_confirmation_instructions
      mail = ActionMailer::Base.deliveries.last
      expect(mail.from).to include('noreply@example.com')
    end
  end
end
