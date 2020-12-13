require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json.count).to eq(3)
    expect(json.first).to have_key :data
    expect(json.first[:data]).to be_a(Array)
    expect(json.first[:data].first).to be_a(Hash)

    merchant = json.first[:data].first[:attributes]

    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to be_a(String)
  end
end
