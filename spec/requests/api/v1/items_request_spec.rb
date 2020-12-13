require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json.count).to eq(3)
    expect(json.first).to have_key :data
    expect(json.first[:data]).to be_a(Array)
    expect(json.first[:data].first).to be_a(Hash)

    item = json.first[:data].first[:attributes]

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
