class Api::V1::Items::SearchController < ApplicationController
  def index
    attribute = params.keys.first
    if attribute == 'unit_price'
      render json: {
        error: 'Invalid Syntax, Try another attribute',
        status: 400
      }, status: 400
    else
      render json: ItemSerializer.new(Item.where("#{attribute} ILIKE ?", "%#{params[attribute]}%"))
    end
  end

  def show
    attribute = params.keys.first
    render json: ItemSerializer.new(Item.where("#{attribute} ILIKE ?", "%#{params[attribute]}%").first)
  end
end
