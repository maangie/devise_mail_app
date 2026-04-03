require 'rails_helper'

RSpec.describe "Request limits", type: :request do
  let(:app) { Rack::MockRequest.new(Rails.application) }

  it "pins Rack query parser limits in application boot" do
    parser = Rack::Utils.default_query_parser

    expect(Rack::Utils.param_depth_limit).to eq(32)
    expect(parser.instance_variable_get(:@bytesize_limit)).to eq(1_048_576)
    expect(parser.instance_variable_get(:@params_limit)).to eq(1_024)
    expect(Rack::Utils.multipart_total_part_limit).to eq(1_024)
  end

  it "rejects requests with too many urlencoded parameters" do
    body = ([ "user[email]=user@example.com", "user[password]=password123" ] +
      (1..1_100).map { |index| "extra#{index}=1" }).join('&')

    expect {
      app.post(
        "/users/sign_in",
        "HTTP_HOST" => "localhost",
        "CONTENT_TYPE" => "application/x-www-form-urlencoded",
        input: body
      )
    }.to raise_error(
      ActionController::BadRequest,
      /exceeds limit \(1024\)/
    )
  end
end
