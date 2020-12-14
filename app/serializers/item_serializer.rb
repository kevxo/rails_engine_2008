class ItemSerializer
  def self.format_item(items)
    results = items.map do |item|
      {
        id: item.id,
        type: 'item',
        attributes: {
          name: item.name,
          description: item.description,
          unit_price: item.unit_price,
          merchant_id: item.merchant_id
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

  def self.an_item(item)
    {
      data: {
        id: item.id,
        type: 'item',
        attributes: {
          name: item.name,
          description: item.description,
          unit_price: item.unit_price,
          merchant_id: item.merchant_id
        }
      }
    }
  end
end
