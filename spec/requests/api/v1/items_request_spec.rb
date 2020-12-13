require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    create_list(:item, 3)

    get '/api/v1/items'

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

  it 'can get one item by its id' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(json).to have_key(:data)
    expect(json[:data][:id]).to eq(id)

    item = json[:data][:attributes]

    expect(item).to have_key :name
    expect(item[:name]).to be_a(String)

    expect(item).to have_key :description
    expect(item[:description]).to be_a(String)

    expect(item).to have_key :unit_price
    expect(item[:unit_price]).to be_a(Float)

    expect(item).to have_key :merchant_id
    expect(item[:merchant_id]).to be_a(Integer)
  end
end
