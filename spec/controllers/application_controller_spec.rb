require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  it 'ActionController::Base を継承している' do
    expect(described_class.superclass).to eq(ActionController::Base)
  end

  it 'テスト環境ではCSRF保護が無効になっている' do
    expect(described_class.allow_forgery_protection).to be false
  end
end
