require 'rails_helper'

describe 'Buisness Intelligence' do
  describe 'Merchants with most revenue' do
    it 'should return a variable number of merchants ranked by total revenue' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      customer = create(:customer)

      item1 = create(:item, merchant_id: merchant1.id)
      item2 = create(:item, merchant_id: merchant1.id)
      item3 = create(:item, merchant_id: merchant2.id)

      invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
      invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)

      create(:transaction, invoice_id: invoice1.id, result: 'success')
      create(:transaction, invoice_id: invoice2.id, result: 'success')
      create(:transaction, invoice_id: invoice3.id, result: 'success')

      create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
      create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id)
      create(:invoice_item, item_id: item3.id, invoice_id: invoice3.id)

      quantity = 2

      get "/api/v1/merchants/most_revenue?quantity=#{quantity}"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json).to have_key :data
      expect(json[:data].count).to eq(2)
      expect(json[:data].first[:attributes][:name]).to eq(merchant1.name)
      expect(json[:data].first[:attributes][:name]).to_not eq(merchant2.name)
    end
  end
end
