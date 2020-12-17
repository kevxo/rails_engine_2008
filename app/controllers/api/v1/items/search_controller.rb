module Api
  module V1
    module Items
      class SearchController < ApplicationController
        def index
          attribute = params.keys.first
          if attribute == 'unit_price'
            render json: {
              error: 'Invalid Syntax, Try another attribute',
              status: 400
            }, status: 400
          else
            render json: ItemSerializer.new(Item.find_all_items(attribute, params[attribute]))
          end
        end

        def show
          attribute = params.keys.first
          if attribute == 'unit_price'
            render json: {
              error: 'Invalid Syntax, Try another attribute',
              status: 400
            }, status: 400
          else
            render json: ItemSerializer.new(Item.find_item(attribute, params[attribute]))
          end
        end
      end
    end
  end
end
