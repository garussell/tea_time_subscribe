require 'rails_helper'

RSpec.describe "Subscriptions", type: :request do
  before do
    @customer = Customer.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      address: Faker::Address.street_address
    )
    
    2.times do
      @customer.subscriptions.create(
        title: Faker::Commerce.product_name,
        price: Faker::Commerce.price,
        status: "active",
        frequency: Faker::Lorem.word
        )
      end

    2.times do
      @customer.subscriptions.create(
        title: Faker::Commerce.product_name,
        price: Faker::Commerce.price,
        status: "cancelled",
        frequency: Faker::Lorem.word
      )
    end
  end

  describe "GET /subscriptions", :vcr do
    it "gets all subscriptions for a customer" do
      get "/api/v0/#{@customer.id}/subscriptions"

      expect(response).to have_http_status(200)

      response_data = JSON.parse(response.body, symbolize_names: true)
      
      result = response_data[:data]
      expect(result.count).to eq(4)
      expect(result[0][:attributes][:status]).to eq("active")
      expect(result[1][:attributes][:status]).to eq("active")

      expect(result[2][:attributes][:status]).to eq("cancelled")
      expect(result[3][:attributes][:status]).to eq("cancelled")

      expect(result[0]).to have_key(:id)
      expect(result[0][:id]).to be_a(String)

      expect(result[0]).to have_key(:type)
      expect(result[0][:type]).to eq("subscription")
      
      expect(result[0]).to have_key(:attributes)
      expect(result[0][:attributes]).to be_a(Hash)

      expect(result[0][:attributes]).to have_key(:title)
      expect(result[0][:attributes][:title]).to be_a(String)

      expect(result[0][:attributes]).to have_key(:price)
      expect(result[0][:attributes][:price]).to be_a(Float)

      expect(result[0][:attributes]).to have_key(:status)
      expect(result[0][:attributes][:status]).to be_a(String)

      expect(result[0][:attributes]).to have_key(:frequency)
      expect(result[0][:attributes][:frequency]).to be_a(String)
    end

    it "returns an error if customer is not found" do
      get "/api/v0/0/subscriptions"

      expect(response).to have_http_status(404)

      response_data = JSON.parse(response.body, symbolize_names: true)
     
      result = response_data[:errors].first
      expect(result[:detail]).to eq("Customer not found")
    end
  end
end