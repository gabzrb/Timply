PACKS = {"Pack Vert": { "20g": ["0.83", "0.88"], "100g": ["1.67","1.76"], "250g": ["3.34", "3.52"], "500g": ["5","5.28"], "3kg": ["6.7","7.04"]},
"Pack Prioritaire": {"20g": ["1","1.05"], "100g": ["2","2.10"], "250g": ["4","4.20"], "500g": ["6","6.30"], "2kg": ["8","8.40"]},
"Pack Prioritaire Internationale": { "20g": ["1.23","1.30"], "100g": ["2.47","2.60"], "250g": ["6.17","6.5"],"500g": ["9.9","10.40"], "2kg": ["17.30","18.20"], "3kg": ["30.4","32.00"]},
"Pack Suivie": {"20g": ["1.20","1.28"], "100g": ["2","2.16"], "250g": ["3.7","3.92"], "500g": ["5.4","5.68"], "2kg": ["7","7.44"], "3kg": ["7","7.44"]},
"Pack Suivie Internationale": { "20g": ["'4.25","4.50"], "100g": ["5.5","5.80"], "250g": ["9.2","9.70"],"500g": ["12.92","13.60"], "2kg": ["20.33","21.40"], "3kg": ["33.45","35.20"]},
"Pack R1": { "20g": ["'4","4.18"],"50g": ["4.46","4.70"], "100g": ["5.08","5.35"], "250g": ["6.20","6.50"],"500g": ["7.26","7.65"],"1kg": ["8.3","8.75"], "2kg": ["9.9","10.40"], "3kg": ["11","11.60"]},
"Pack R2": { "20g": ["'4.65","4.90"],"50g": ["5.20","5.45"], "100g": ["5.75","6.05"], "250g": ["6.88","7.25"],"500g": ["7.88","8.30"],"1kg": ["9","9.50"], "2kg": ["10.5","11.10"], "3kg": ["11.68","12.30"]},
"Pack R3": { "20g": ["5.75","6.05"],"50g": ["6.17","6.50"], "100g": ["6.74","7.10"], "250g": ["7.93","8.35"],"500g": ["8.88","9.35"],"1kg": ["9","10.55"], "2kg": ["11.6","12.25"], "3kg": ["12.73","13.40"]},
"Pack R1 Internationale":  { "20g": ["5.5","5.80"], "100g": ["6.75","7.10"], "250g": ["10.45","11"],"500g": ["14.15","14.90"],"2kg": ["21.55","22.70"] },
"Pack R2 Internationale":  { "20g": ["6.46","6.80"], "100g": ["7.69","8.10"], "250g": ["11.4","12"], "500g": ["15.1","15.9"],"2kg": ["22.5","23.70"] }}


class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy, :edit, :update]
  before_action :check_admin, only: [:index]
  def index
    @orders = Order.all
  end

  def show
    @la_poste_price = Money.new(((PACKS[@order.category.to_sym][@order.weight.to_sym].last.to_f)*@order.quantity.to_i)* 100, 'EUR')
    @reduction = @la_poste_price - @order.price
  end

  def create
    @pack = Pack.find(params[:pack_id])
    @order = Order.new(order_params)
    @order.pack_sku = @order.category
    @order.state = 'pending'
    @order.price = (PACKS[@order.category.to_sym][@order.weight.to_sym].first.to_f)*@order.quantity.to_i
    @order.user_id = current_user.id
    @order.pack_id = @pack.id
    if @order.save!
      redirect_to pack_order_path(@pack, @order)
    else
      flash.now[:error] = "Oops, something went wrong. Please try again"
      render :new
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_path
  end

  def edit
  end

  def update
    if @order.update(order_edit_params)
      redirect_to orders_path
    else
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:category, :weight, :quantity)
  end

  def order_edit_params
    params.require(:order).permit(:tracking)
  end

  def check_admin
    redirect_to packs_path if !(current_user.admin)
  end

  def set_order
    @order =  Order.find(params[:id])
  end
end
