class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.all
    render json: ItemSerializer.format_item(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.an_item(item)
  end

  def create
    item = Item.create(item_params)
    render json: ItemSerializer.an_item(item)
  end

  def update
    item = Item.update(params[:id], item_params)
    render json: ItemSerializer.an_item(item)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
