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
  end
end
