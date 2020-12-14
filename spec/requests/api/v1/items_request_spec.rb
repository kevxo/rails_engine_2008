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

  it 'can create a new item' do
    merchant = create(:merchant).id
    item_params = {
      name: 'Xbox 1',
      description: 'Awesome Console!',
      unit_price: 250.00,
      merchant_id: merchant
    }

    headers = { 'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last
    expect(response).to be_successful

    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it 'can update an existing item' do
    id = create(:item).id

    previous_description = Item.last.description
    item_params = { description: 'Console has a lot of great features'}
    headers = {'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.description).to_not eq(previous_description)
    expect(item.description).to eq('Console has a lot of great features')
  end
end
