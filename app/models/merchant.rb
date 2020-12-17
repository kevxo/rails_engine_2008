class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices

  validates_presence_of :name

  def self.find_merchant(attribute, value)
    where("#{attribute} ILIKE ?", "%#{value}%").first
  end

  def self.find_all_merchants(attribute, value)
    where("#{attribute} ILIKE ?", "%#{value}%")
  end

  def self.most_revenue(limit = 2)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:transactions, :invoice_items])
    .merge(Transaction.successful)
    .group(:id)
    .order("revenue DESC")
    .limit(limit)
  end

  def self.most_items_sold(limit = 2)
    select("merchants.*, SUM(invoice_items.quantity) AS sold")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order('sold DESC')
    .limit(limit)
  end

  def self.revenue_date_range(start_date, end_date)
    joins(invoices: [:invoice_items, :transactions])
    .where(
      transactions: {result: 'success'},
      invoices: {created_at: (start_date)..("#{end_date} 23:59:59"), status: 'shipped'}
    )
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def self.revenue(merchant_id)
    joins(invoices: [:invoice_items, :transactions])
    .where(
      transactions: {result: 'success'},
      merchants: {id: merchant_id}
    )
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
