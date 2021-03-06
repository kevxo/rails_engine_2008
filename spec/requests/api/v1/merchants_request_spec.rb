require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

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

  it 'can get one item by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(json).to have_key(:data)
    expect(json[:data][:id]).to eq(id.to_s)

    merchant = json[:data][:attributes]

    expect(merchant).to have_key :name
    expect(merchant[:name]).to be_a(String)
  end

  it 'can create a new merchant' do
    merchant_params = {
      name: 'Games for all'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/merchants', headers: headers, params: JSON.generate(merchant_params)
    created_merchant = Merchant.last
    expect(response).to be_successful
    expect(created_merchant.name).to eq(merchant_params[:name])
  end

  it 'can update an existing merchant' do
    id = create(:merchant).id

    previous_name = Merchant.last.name
    merchant_params = { name: 'All Games' }
    headers = {'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/merchants/#{id}", headers: headers, params: JSON.generate(merchant_params)
    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq('All Games')
  end

  it 'can destroy an item' do
    merchant = create(:merchant)

    expect { delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)

    expect(response).to be_successful
    expect { Merchant.find(merchant.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end

describe 'relationships' do
  it 'can get all items for that merchant' do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

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
end
