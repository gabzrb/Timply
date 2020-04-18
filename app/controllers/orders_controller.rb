PACKS =
{"Lettre Verte": { "20g": ["0.79", "0.88"],  "100g": ["1.58","1.76"], "250g": ["3.16", "3.52"], "500g": ["4.75","5,28"], "3kg": ["6.33","7.04"]},

         "Lettre Prioritaire": {"20g": ["0.94","1.05"], "100g": ["1.90","2.10"], "250g": ["3.78","4.20"], "500g": ["5.67","6.30"], "3kg": ["7.56","8.40"]},

         "Lettre Prioritaire Internationale": { "20g": ["1.17","1.30"],  "100g":["2.34","2.60"], "250g":["5.85","6.5"], "500g": ["9.36","10.40"],"2kg": ["16.38","18.20"], "3kg": ["28.8","32.00"]},

         "Lettre Suivie": {"20g": ["1.29","1.45"], "100g": ["2.10","3.49"], "250g": ["3.49","5.50"], "500g": ["5.12","7.30"],"1kg": ["6.63","9.20"], "2kg": ["6.63","9.20"], "3kg": ["6.63","9.20"]},

         "Lettre Suivie Internationale": { "20g": ["'4.36","4.50"], "50g":["5.5","5.80"], "100g": ["5.5","5.80"], "250g":["11.54","13.60"], "500g": ["17.78","21.40"], "3kg": ["28.82","35.20"]},

         "Recommandée R1": { "20g": ["3.98","4.18"], "50g": ["4.46","4.70"], "100g": ["5.08","5.35"], "250g": ["6.20","6.50"],"500g": ["7.26","7.65"],"1kg": ["8.3","8.75"], "2kg": ["9.9","10.40"], "3kg": ["11","11.60"]},
         "Recommandée R2": { "20g": ["4.65","4.90"],"50g": ["5.20","5.45"], "100g": ["5.75","6.05"], "250g": ["6.88","7.25"],"500g": ["7.88","8.30"],"1kg": ["9","9.50"], "2kg": ["10.5","11.10"], "3kg": ["11.68","12.30"]},
         "Recommandée R3": { "20g": ["5.75","6.05"],"50g": ["6.17","6.50"], "100g": ["6.74","7.10"], "250g": ["7.93","8.35"],"500g": ["8.88","9.35"],"1kg": ["9","10.55"], "2kg": ["11.6","12.25"], "3kg": ["12.73","13.40"]},
         "Recommandée R1 Internationale":  { "20g": ["5.5","5.80"], "50g": ["6.75","7.10"], "100g": ["6.75","7.10"], "250g": ["10.45","11"],"500g": ["14.15","14.90"],"1kg": ["21.55","22.70"],"2kg": ["21.55","22.70"] , "3kg": ["21.55","22.70"] },
         "Recommandée R2 Internationale":  { "20g": ["6.46","6.80"], "50g": ["7.69","8.10"], "100g": ["7.69","8.10"], "250g": ["11.4","12"], "500g": ["15.1","15.9"],"1kg": ["22.5","23.70"],"2kg": ["22.5","23.70"], "3kg": ["22.5","22.70"] }}



class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy, :edit, :update]
  before_action :check_admin, only: [:index]
  def index
    @orders = Order.all
  end

  def order_confirmation
    @order = Order.find(params[:format])
  end

  def show
    @la_poste_price = Money.new(((PACKS[@order.category.to_sym][@order.weight.to_sym].last.to_f)*@order.quantity.to_i)* 100, 'EUR')
    @la_poste_price += Money.new(115, 'EUR') if ["Recommandée R1", "Recommandée R2", "Recommandée R3"].include?(@order.category)&& @order.ar
    @reduction = @order.reduction
  end

def create
    @pack = Pack.find(params[:pack_id])
    @order = Order.new(order_params)
    @order.pack_sku = @order.category.gsub(' ', '-')
    @order.state = 'pending'
    @order.price = (PACKS[@order.category.to_sym][@order.weight.to_sym].first.to_f)*@order.quantity.to_i if (@order.quantity && @order.weight && @order.category != "")
    @order.reduction = Money.new(((PACKS[@order.category.to_sym][@order.weight.to_sym].last.to_f) * @order.quantity.to_i) * 100, 'EUR') - @order.price if (@order.quantity && @order.weight && @order.category != "")
    if ["Recommandée R1", "Recommandée R2", "Recommandée R3"].include?(@order.category) && @order.ar
      @order.price += Money.new(115, 'EUR')

    end
    if ["Recommandée R1 Internationale", "Recommandée R2 Internationale"].include?(@order.category) && @order.ar
      @order.price += Money.new(140, 'EUR')

    end
    @order.user_id = current_user.id
    @order.pack_id = @pack.id
    @order.cart_id = current_user.cart.id
    if @order.save
      redirect_to pack_order_path(@pack, @order)
    else
      flash[:alert] = "Veuillez remplir les champs"
      redirect_to pack_path(@pack)
    end
  end

  def destroy
    if current_user.admin
      @order.destroy
      redirect_to orders_path
    elsif params[:cart]
      @order.destroy
      redirect_to cart_path(current_user.cart)
    else
      @order.destroy
      redirect_to dashboard_path
    end
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
    params.require(:order).permit(:category, :weight, :quantity, :ar, :pb, :format)
  end

  def order_edit_params
    params.require(:order).permit(:tracking)
  end

  def check_admin
    redirect_to packs_path if !(current_user.admin)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
