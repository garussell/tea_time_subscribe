require 'rails_helper'

RSpec.describe "Subscriptions", type: :request do
  describe "GET /subscriptions", :vcr do
    xit "gets all subscriptions for a customer" do
      id = 1
      get "/api/v0/#{id}/subscriptions"

      expect(response).to have_http_status(200)

      response_data = JSON.parse(response.body, symbolize_names: true)
      result = response_data[:data]
    end
  end
end