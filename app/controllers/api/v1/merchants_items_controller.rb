class Api::V1::MerchantsItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Merchant.find(params[:id]).items)
  end

end