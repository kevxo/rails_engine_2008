require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe '.class methods' do
    it 'finds a merchant corresponding to the value' do
      create_item = create(:item)
      attribute = 'name'
      value = create_item.name

      expect(Item.find_item(attribute, value)).to eq(create_item)
    end

    it 'finds all merchants corresponding to the value' do
      item1 = create(:item, description: 'Great Product')
      item2 = create(:item, description: 'This product needs improvement')
      item3 = create(:item, description: 'Works like a pro')

      attribute = 'description'
      value = 'pr'


      expected = [item1, item2, item3]

      expect(Item.find_all_items(attribute, value)).to eq(expected)
    end
  end
end
