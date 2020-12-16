module Api
  module V1
    module Merchants
      class IntelligenceController < ApplicationController
        def most_revenue
          render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
        end
      end
    end
  end
end