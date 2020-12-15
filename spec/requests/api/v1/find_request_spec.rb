require 'rails_helper'

describe 'Find Endpoints' do
  describe 'Single Finders' do
    it 'display single item record' do
      create_item = create(:item)
      attribute = 'name'
      value = create_item.name

      get "/api/v1/items/find?#{attribute}=#{value}"

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item).to have_key(:data)
      expect(item[:data][:id]).to eq(create_item.id.to_s)

      expect(item[:data][:attributes]).to have_key :name
      expect(item[:data][:attributes][:name]).to be_a(String)

      expect(item[:data][:attributes]).to have_key :description
      expect(item[:data][:attributes][:description]).to be_a(String)

      expect(item[:data][:attributes]).to have_key :unit_price
      expect(item[:data][:attributes][:unit_price]).to be_a(Float)

      expect(item[:data][:attributes]).to have_key :merchant_id
      expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
    end

    it 'display a merchant record' do
      create_merchant = create(:merchant)
      attribute = 'name'
      value = create_merchant.name

      get "/api/v1/merchants/find?#{attribute}=#{value}"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(merchant).to have_key(:data)
      expect(merchant[:data][:id]).to eq(create_merchant.id.to_s)

      expect(merchant[:data][:attributes]).to have_key :name
      expect(merchant[:data][:attributes][:name]).to be_a(String)
    end
  end
end
