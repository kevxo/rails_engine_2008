class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :name

  def self.find_merchant(attribute, value)
    where("#{attribute} ILIKE ?", "%#{value}%").first
  end

  def self.find_all_merchants(attribute, value)
    where("#{attribute} ILIKE ?", "%#{value}%")
  end
end
