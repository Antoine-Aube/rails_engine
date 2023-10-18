class Api::V1::ItemsController < ApplicationController
  before_action :find_item, only: [:destroy, :update]

  def index
    render json: ItemSerializer.new(Item.all)
  end
  
  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.new(item_params) 

    if item.save 
      render json: ItemSerializer.new(item), status: :created
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
  end

  def update 
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: ItemSerializer.new(item)
    else
      render json: { errors: [{ detail: item.errors.full_messages }] }, status: 400
    end
  end

  def find_all
    @items = Item.find_all_items(params[:name])
    render json: ItemSerializer.new(@items)
  end

  private

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end