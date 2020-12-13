class MerchantSerializer
  def self.format_merchant(merchants)
    results = merchants.map do |merchant|
      {
        id: merchant.id,
        type: 'merchant',
        attributes: {
          name: merchant.name
        }
      }
    end
    data(results)
  end

  def self.data(results)
    {
      data: results
    }
  end

  def self.a_merchant(merchant)
    {
      data: {
        id: merchant.id,
        type: 'merchant',
        attributes: {
          name: merchant.name
        }
      }
    }
  end

  def self.create_merchant(merchant)
    {
      data: {
        id: merchant.id,
        type: 'merchant',
        attributes: {
          name: merchant.name
        }
      }
    }
  end
end
