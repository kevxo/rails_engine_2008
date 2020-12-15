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

      create(:transaction, invoice_id: invoice1.id)
      create(:transaction, invoice_id: invoice2.id)
      create(:transaction, invoice_id: invoice3.id)

      create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id )
      create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id )
      create(:invoice_item, item_id: item3.id, invoice_id: invoice3.id )
    end
  end
end