class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.where('name ILIKE ?', "%#{params[:name]}%").first)
  end
end