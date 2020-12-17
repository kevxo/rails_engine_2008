require 'rails_helper'

describe 'Buisness Intelligence' do
  describe 'Merchants with most revenue' do
    before :each do
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @customer = create(:customer)

      @item1 = create(:item, merchant_id: @merchant1.id, unit_price: 20.00)
      @item2 = create(:item, merchant_id: @merchant1.id, unit_price: 40.00)
      @item3 = create(:item, merchant_id: @merchant2.id, unit_price: 15.00)

      @invoice1 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant1.id, created_at: '2012-03-24', status: 'shipped')
      @invoice2 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant1.id, created_at: '2012-03-24', status: 'shipped')
      @invoice3 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant2.id, created_at: '2012-03-24', status: 'shipped')

      create(:transaction, invoice_id: @invoice1.id, result: 'success')
      create(:transaction, invoice_id: @invoice2.id, result: 'success')
      create(:transaction, invoice_id: @invoice3.id, result: 'success')

      create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, quantity: 20)
      create(:invoice_item, item_id: @item2.id, invoice_id: @invoice2.id, quantity: 50)
      create(:invoice_item, item_id: @item3.id, invoice_id: @invoice3.id, quantity: 10)

      @quantity = 2
    end

    it 'should return a variable number of merchants ranked by total revenue' do
      get "/api/v1/merchants/most_revenue?quantity=#{@quantity}"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json).to have_key :data
      expect(json[:data].count).to eq(2)
      expect(json[:data].first[:attributes][:name]).to eq(@merchant1.name)
      expect(json[:data].first[:attributes][:name]).to_not eq(@merchant2.name)
    end

    it 'should return merchants with most items sold' do
      get "/api/v1/merchants/most_items?quantity=#{@quantity}"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json).to have_key :data
      expect(json[:data].count).to eq(2)
      expect(json[:data].first[:attributes][:name]).to eq(@merchant1.name)
      expect(json[:data].first[:attributes][:name]).to_not eq(@merchant2.name)
    end

    it 'should return total revenue across all merchants, given date range' do

      get '/api/v1/revenue?start=2012-03-09&end=2012-03-24'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json).to have_key :data
      expect(json[:data][:id]).to eq(nil)
      expect(json[:data][:attributes][:revenue]).to be_a(Float)
    end

    it 'should return revenue for a merchant' do

      get "/api/v1/merchants/#{@merchant1.id}/revenue"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json).to have_key :data
      expect(json[:data][:id]).to eq(nil)
      expect(json[:data][:attributes][:revenue]).to be_a(Float)
    end
  end
end
