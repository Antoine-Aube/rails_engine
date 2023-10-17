require 'rails_helper'

RSpec.describe 'Merchants API' do
  describe 'response for all merchants' do 
    it "send a formatted JSON reponse of all merchants" do 
      create_list(:merchant, 10)

      get '/api/v1/merchants'

      expect(response).to be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)
      merchants = parsed_response[:data]
      # require 'pry';binding.pry
      expect(merchants.count).to eq(10)

      merchants.each do |merchant|
        expect(merchant).to have_key(:id) 
        expect(merchant[:id]).to be_an(String)
        
        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_an(String)

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_an(Hash)
      end
    end 
  end
end