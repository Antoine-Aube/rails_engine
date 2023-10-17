require 'rails_helper'

RSpec.describe 'Items API' do
  describe 'response for all items' do
    it "sends a formatted JSON response of all items" do
      create_list(:item, 10)

      get '/api/v1/items'

      expect(response).to be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)
      # require 'pry';binding.pry
      items = parsed_response[:data]
      # require 'pry';binding.pry
      expect(items.count).to eq(10)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_an(String) 

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_an(Hash)
      end

      item_attributes = items.first[:attributes]
      # require 'pry';binding.pry
      expect(item_attributes).to have_key(:name) 
      expect(item_attributes[:name]).to be_an(String)

      expect(item_attributes).to have_key(:description)
      expect(item_attributes[:description]).to be_an(String)
      
      expect(item_attributes).to have_key(:unit_price) 
      expect(item_attributes[:unit_price]).to be_an(Float)

      expect(item_attributes).to have_key(:merchant_id)
      expect(item_attributes[:merchant_id]).to be_an(Integer)
    end
  end

  describe "response for a single item" do 
    it "sends a formatted JSON response for a single item" do
      id = create(:item).id
    
      get "/api/v1/items/#{id}"
      expect(response).to be_successful

      formatted_item = JSON.parse(response.body, symbolize_names: true)
      item = formatted_item[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_an(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_an(Hash)

      item_attributes = item[:attributes]

      expect(item_attributes).to have_key(:name) 
      expect(item_attributes[:name]).to be_an(String)

      expect(item_attributes).to have_key(:description)
      expect(item_attributes[:description]).to be_an(String)
      
      expect(item_attributes).to have_key(:unit_price) 
      expect(item_attributes[:unit_price]).to be_an(Float)

      expect(item_attributes).to have_key(:merchant_id)
      expect(item_attributes[:merchant_id]).to be_an(Integer)
    end
  end
end