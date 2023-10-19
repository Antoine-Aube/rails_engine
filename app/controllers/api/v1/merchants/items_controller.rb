class Api::V1::Merchants::ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_response

  def index
    render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
  end

private

  def invalid_response(error)
    render json: ErrorSerializer.new(ErrorMessage.new(error.message, 404)).serialize_json, status: 404
  end
end