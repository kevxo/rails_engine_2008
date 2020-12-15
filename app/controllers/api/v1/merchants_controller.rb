module Api
  module V1
    class MerchantsController < ApplicationController
      def index
        render json: MerchantSerializer.new(Merchant.all)
      end

      def show
        render json: MerchantSerializer.new(Merchant.find(params[:id]))
      end

      def create
        render json: MerchantSerializer.new(Merchant.create(merchant_params))
      end

      def update
        render json: MerchantSerializer.new(Merchant.update(params[:id], merchant_params))
      end

      def destroy
        render json: Merchant.destroy(params[:id])
      end

      private

      def merchant_params
        params.require(:merchant).permit(:name)
      end
    end
  end
end
