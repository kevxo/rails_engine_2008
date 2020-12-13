class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all
    render json: MerchantSerializer.format_merchant(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.a_merchant(merchant)
  end
end