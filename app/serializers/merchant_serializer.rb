class MerchantSerializer
  def self.format_merchant(merchants)
    merchants.map do |merchant|
      {
        data: [
          {
            id: merchant.id,
            type: 'merchant',
            attributes: {
              name: merchant.name
            }
          }
        ]
      }
    end
  end
end