class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    begin
      render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
    rescue ActiveRecord::RecordNotFound => e
      render json: ErrorSerializer.new(ErrorMessage.new(e.message, 404)).serialize_json, status: 404
    end 
  end
end