class OrdersController < ApplicationController
  before_action :set_order, only: [:show]
  before_action :check_admin, only: [:index]
  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
    @pack = Pack.find(params[:pack_id])
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.pack_id = @pack.id
    if @order.save!
      redirect_to :show
    else
      flash.now[:error] = "Oops, something went wrong. Please try again"
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:price)
  end

  def check_admin
    if current_user.admin
      redirect_to pack_orders_path
    else
      redirect_to packs_path
    end
  end

  def set_order
    @order =  Order.find(params[:id])
  end
end
