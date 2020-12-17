require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe '.class methods' do
    it 'finds a merchant' do
      create_merchant = create(:merchant)
      attribute = 'name'
      value = create_merchant.name


      expect(Merchant.find_merchant(attribute, value)).to eq(create_merchant)
    end

    it 'finds all merchants' do
      merchant1 = create(:merchant, name: 'Steve Madden')
      merchant2 = create(:merchant, name: 'Steve Smith')
      merchant3 = create(:merchant, name: 'Bobby Steve')

      attribute = 'name'
      value = 'St'

      expected = [merchant1, merchant2, merchant3]
      expect(Merchant.find_all_merchants(attribute, value)).to eq(expected)
    end

    it 'most revenue' do
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

      create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id )
      create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id )
      create(:invoice_item, item_id: item3.id, invoice_id: invoice3.id )

      quantity = 2

      expect(Merchant.most_revenue(quantity)).to eq([merchant1, merchant2])
    end

    it 'most items sold' do
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

      create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id )
      create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id )
      create(:invoice_item, item_id: item3.id, invoice_id: invoice3.id )

      quantity = 2

      expect(Merchant.most_items_sold(quantity)).to eq([merchant1, merchant2])
    end
    it 'revenue_date_range' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      customer = create(:customer)

      item1 = create(:item, merchant_id: merchant1.id, unit_price: 20.00)
      item2 = create(:item, merchant_id: merchant1.id, unit_price: 40.00)
      item3 = create(:item, merchant_id: merchant2.id, unit_price: 15.00)

      invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id, created_at: '2020-12-09', status: 'shipped')
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id, created_at: '2020-12-09', status: 'shipped')
      invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id, created_at: '2020-12-09', status: 'shipped')

      create(:transaction, invoice_id: invoice1.id, result: 'success')
      create(:transaction, invoice_id: invoice2.id, result: 'success')
      create(:transaction, invoice_id: invoice3.id, result: 'success')

      create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, quantity: 20)
      create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id, quantity: 50)
      create(:invoice_item, item_id: item3.id, invoice_id: invoice3.id, quantity: 10)

      start_date = '2020-12-01'
      end_date = '2020-12-16'

      expected = 120.00

      expect(Merchant.revenue_date_range(start_date, end_date)).to eq(expected)
    end
  end
end
