require 'rails_helper'

RSpec.describe "Subscribe", type: :request do
  before do
    @customer = Customer.create!(
      first_name: "John",
      last_name: "Doe",
      email: "email@gmail.com",
      address: "123 Main St"
    )
  end

  describe "POST /subscribe", :vcr do
    it "subscribe a customer to tea" do
      post "/api/v0/subscribe", params: {
        subscription: {
          title: "black tea",
          price: 10.99,
          status: "active",
          frequency: "2x per month",
          customer_id: @customer.id
        }
      }      

      expect(response).to have_http_status(201)

      response_data = JSON.parse(response.body, symbolize_names: true)
      result = response_data[:data]

      expect(result[:type]).to eq("subscription")
      expect(result[:id]).to_not be_nil

      expect(result[:attributes][:title]).to eq("black tea")
      expect(result[:attributes][:price]).to eq(10.99)
      expect(result[:attributes][:status]).to eq("active")
      expect(result[:attributes][:frequency]).to eq("2x per month")
      expect(result[:attributes][:customer_id]).to eq(@customer.id)
    end
  end

  describe "sad path", :vcr do
    it "returns an error if customer is missing" do
      post "/api/v0/subscribe", params: {
        subscription: {
          title: "black tea",
          price: 10.99,
          status: "active",
          frequency: "2x per month"
        }
      } 

      expect(response).to have_http_status(404)
      response_data = JSON.parse(response.body, symbolize_names: true)

      result = response_data[:errors].first
      expect(result[:detail]).to eq("Customer not found")
    end

    it "returns an error if title is missing" do
      post "/api/v0/subscribe", params: {
        subscription: {
          # title: "black tea",
          price: 10.99,
          status: "active",
          frequency: "2x per month",
          customer_id: @customer.id
        }
      } 

      expect(response).to have_http_status(400)
      response_data = JSON.parse(response.body, symbolize_names: true)
      result = response_data[:errors].first
      expect(result[:detail]).to eq("Title can't be blank")
    end

    it "returns an error if price is missing" do
      post "/api/v0/subscribe", params: {
        subscription: {
          title: "black tea",
          # price: 10.00,
          status: "active",
          frequency: "2x per month",
          customer_id: @customer.id
        }
      }

      expect(response).to have_http_status(400)
      response_data = JSON.parse(response.body, symbolize_names: true)
      result = response_data[:errors].first
      expect(result[:detail]).to eq("Price can't be blank")
    end

    it "returns an error if frequency is missing" do
      post "/api/v0/subscribe", params: {
        subscription: {
          title: "black tea",
          price: 10.99,
          status: "active",
          # frequency: "2x per month",
          customer_id: @customer.id
        }
      }

      expect(response).to have_http_status(400)
      response_data = JSON.parse(response.body, symbolize_names: true)
      result = response_data[:errors].first
      expect(result[:detail]).to eq("Frequency can't be blank")
    end
  end
end