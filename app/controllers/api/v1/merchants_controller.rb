class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all
    render json: MerchantSerializer.format_merchant(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.a_merchant(merchant)
  end

  def create
    merchant = Merchant.create(merchant_params)
    render json: MerchantSerializer.create_merchant(merchant)
  end

  def update
    render json: Merchant.update(params[:id], merchant_params)
  end

  private

    def merchant_params
      params.require(:merchant).permit(:name)
    end
end