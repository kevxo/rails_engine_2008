class Api::V1::Merchants::SearchController < ApplicationController
  def index
    attribute = params.keys.first
    render json: MerchantSerializer.new(Merchant.where("#{attribute} ILIKE ?", "%#{params[attribute]}%"))
  end

  def show
    attribute = params.keys.first
    render json: MerchantSerializer.new(Merchant.where("#{attribute} ILIKE ?", "%#{params[attribute]}%").first)
  end
end