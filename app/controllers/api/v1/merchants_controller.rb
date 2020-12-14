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
    render json: MerchantSerializer.a_merchant(merchant)
  end

  def update
    merchant = Merchant.update(params[:id], merchant_params)
    render json: MerchantSerializer.a_merchant(merchant)
  end

  def destroy
    render json: Merchant.destroy(params[:id])
  end

  def merchant_items
    items = Item.where(merchant_id: params[:merchant_id])
    render json: ItemSerializer.format_item(items)
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
