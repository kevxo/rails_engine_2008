class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all
    render json: MerchantSerializer.format_merchant(merchants)
  end
end