class Api::V1::ItemsController < ApplicationController
  before_action :find_item, only: [:destroy, :update]
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

  def index
    render json: ItemSerializer.new(Item.all)
  end
  
  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.new(item_params) 
    item.save 
    render json: ItemSerializer.new(item), status: :created
  end

  def destroy
    @item.destroy
  end

  def update 
    item = Item.find(params[:id])
    item.update!(item_params)
    render json: ItemSerializer.new(item)
  end

  def search
    if params[:name].present? && params[:max_price].present?
      render json: { errors: "Please enter only one parameter" }, status: 400
    elsif params[:name].present? && params[:min_price].present?
      render json: { errors: "Please enter only one parameter" }, status: 400
    elsif params[:max_price].to_f < 0 || params[:min_price].to_f < 0
      render json: { errors: "Please enter a positive number" }, status: 400
    elsif params[:min_price]
      min_items = Item.find_by_min_price(params[:min_price])
      render json: ItemSerializer.new(min_items)
    elsif params[:max_price]
      max_items =Item.find_by_max_price(params[:max_price])
      render json: ItemSerializer.new(max_items)
    elsif params[:name]
      @items = Item.find_all_items_search(params[:name])
      render json: ItemSerializer.new(@items)
    end
  end

  private

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

  def invalid_response(error)
    render json: ErrorSerializer.new(ErrorMessage.new(error.message, 400)).serialize_json, status: 400
  end
end