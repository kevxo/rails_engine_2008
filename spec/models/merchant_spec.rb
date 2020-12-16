require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
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
  end
end
