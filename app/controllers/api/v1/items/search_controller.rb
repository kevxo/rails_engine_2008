class Api::V1::Items::SearchController < ApplicationController
  def show
    attribute = params.keys.first
    render json: ItemSerializer.new(Item.where("#{attribute} ILIKE ?", "%#{params[attribute]}%").first)
  end
end