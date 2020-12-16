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
end
