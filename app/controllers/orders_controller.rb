class OrdersController < ApplicationController
    before_action :set_order, only: [:show]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
  end

  def create
  end

  private

  def set_order
    @order =  Order.find(params[:id])
  end
end
