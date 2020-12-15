class Api::V1::Merchants::SearchController < ApplicationController
  def show
    attribute = params.keys.first
    render json: MerchantSerializer.new(Merchant.where("#{attribute} ILIKE ?", "%#{params[attribute]}%").first)
  end
end