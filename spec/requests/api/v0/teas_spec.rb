require 'rails_helper'

RSpec.describe "Teas", type: :request do
  describe "GET /api/v0/teas", :vcr do
    it "returns all teas" do
      get "/api/v0/teas", params: { query: "tea" }

      expect(response).to have_http_status(:success)

      response_body = JSON.parse(response.body, symbolize_names: true)

      teas = response_body[:data]

      expect(teas.first).to have_key(:id)
      expect(teas.first[:id]).to be_a(String)
      
      expect(teas.first).to have_key(:type)
      expect(teas.first[:type]).to be_a(String)

      expect(teas.first).to have_key(:attributes)
      expect(teas.first[:attributes]).to be_a(Hash)

      expect(teas.first[:attributes]).to have_key(:title)
      expect(teas.first[:attributes][:title]).to be_a(String)

      expect(teas.first[:attributes]).to have_key(:description)
      expect(teas.first[:attributes][:description]).to be_a(String)

      expect(teas.first[:attributes]).to have_key(:image)
      expect(teas.first[:attributes][:image]).to be_a(String)

      expect(teas.first[:attributes]).to have_key(:link)
      expect(teas.first[:attributes][:link]).to be_a(String)
    end
  end
end