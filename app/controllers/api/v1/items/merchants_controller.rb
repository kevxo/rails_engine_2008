module Api
  module V1
    module Items
      class MerchantsController < ApplicationController
        def index
          item = Item.find(params[:id])
          render json: MerchantSerializer.new(Merchant.find(item.merchant_id))
        end
      end
    end
  end
end
