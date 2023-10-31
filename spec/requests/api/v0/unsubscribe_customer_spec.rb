require 'rails_helper'

RSpec.describe "Cancel Subscriptions", type: :request do
  before do
    @customer = Customer.create!(
      first_name: "John",
      last_name: "Doe",
      email: "email@gmail.com",
      address: "123 Main St"
    )

    @subscription = @customer.subscriptions.create!(
      title: "Sample Subscription",
      price: 10.00,
      status: "active",
      frequency: "monthly",
      customer_id: @customer.id
    )
  end

  describe "PATCH /cancel", :vcr do
    it "cancels a subscription" do
      patch "/api/v0/cancel/#{@subscription.id}"

      expect(response).to have_http_status(200)
      response_data = JSON.parse(response.body, symbolize_names: true)

      result = response_data[:data]

      expect(result[:attributes][:status]).to eq("cancelled")
    end

    it "returns an error if subscription is not found" do
      patch "/api/v0/cancel/0"

      expect(response).to have_http_status(404)
      response_data = JSON.parse(response.body, symbolize_names: true)

      result = response_data[:error]
      expect(result).to eq("Subscription not found")
    end
  end
end