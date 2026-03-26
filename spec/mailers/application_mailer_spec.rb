require 'rails_helper'

RSpec.describe ApplicationMailer, type: :mailer do
  it 'ActionMailer::Base を継承している' do
    expect(described_class.superclass).to eq(ActionMailer::Base)
  end

  it 'デフォルトのfromアドレスが設定されている' do
    expect(described_class.default_params[:from]).to eq('from@example.com')
  end

  it 'メール配信方法がtestになっている' do
    expect(ActionMailer::Base.delivery_method).to eq(:test)
  end
end
