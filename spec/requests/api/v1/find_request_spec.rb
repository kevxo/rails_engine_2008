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

  describe 'Multi-Finders' do
    it 'displays all merchants that match search params' do
      create(:merchant, name: 'Steve Madden')
      create(:merchant, name: 'Steve Smith')
      create(:merchant, name: 'Bobby Steve')

      attribute = 'name'
      value = 'St'

      get "/api/v1/merchants/find_all?#{attribute}=#{value}"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].count).to eq(3)
      expect(json).to have_key :data
      expect(json[:data]).to be_a(Array)
      expect(json[:data].first).to be_a(Hash)

      merchants = json[:data]

      merchants.each do |merchant|
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it 'displays all items that match search params' do
      create(:item, description: 'Great Product')
      create(:item, description: 'This product needs improvement')
      create(:item, description: 'Works like a pro')

      attribute = 'description'
      value = 'pr'

      get "/api/v1/items/find_all?#{attribute}=#{value}"

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].count).to eq(3)
      expect(json).to have_key :data
      expect(json[:data]).to be_a(Array)
      expect(json[:data].first).to be_a(Hash)

      items = json[:data]

      items.each do |item|
        expect(item[:attributes]).to have_key :name
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key :description
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key :unit_price
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key :merchant_id
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end

    it 'displays all items that match unit_price' do
      create(:item, unit_price: 20.00)
      create(:item, unit_price: 205.20)
      create(:item, unit_price: 52.20)

      attribute = 'unit_price'
      value = 20

      get "/api/v1/items/find_all?#{attribute}=#{value}"

      expect(response.code).to eq('400')

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to have_key :error
      expect(json[:error]).to eq('Invalid Syntax, Try another attribute')
    end
  end
end
