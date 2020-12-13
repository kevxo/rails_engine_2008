class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.all
    render json: ItemSerializer.format_item(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.an_item(item)
  end
end