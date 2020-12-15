class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.where('name ILIKE ?', "%#{params[:name]}%").first)
  end
end