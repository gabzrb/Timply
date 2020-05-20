PACKS =
{"Lettre Verte": { "20g": ["0.79", "0.97"],  "100g": ["1.59","1.94"], "250g": ["3.10", "3.88"], "500g": ["4.10","5.82"], "3kg": ["5.89","7.76"]},

         "Lettre Prioritaire": {"20g": ["1.02","1.16"], "100g": ["1.96","2.23"], "250g": ["3.99","4.64"], "500g": ["5.50", "6.96"], "3kg": ["7.70","9.28"]},

         "Lettre Prioritaire Internationale": { "20g": ["1.17","1.40"],  "100g":["2.40","2.80"], "250g":["4.90","7.00"], "500g": ["7.50", "11.20"],"2kg": ["14.90","19.60"], "3kg": ["28.50","33.60"]},

         "Lettre Suivie": {"20g": ["1.05" ,"1.42"], "100g": ["1.89" ,"2.39"], "250g": ["3.29", "4.33"], "500g": ["4.41","6.27"], "3kg": ["6.36","8.21"]},

         "Lettre Suivie Internationale": { "20g": ["'4.36","4.50"], "50g":["5.5","5.80"], "100g": ["5.5","5.80"], "250g":["11.54","13.60"], "500g": ["17.78","21.40"], "3kg": ["28.82","35.20"]},

         "Recommandée R1": { "20g": ["3.44","4.30"], "100g": ["4.40", "5.50"], "250g": ["5.36", "6.70"], "500g": ["6.28","7.85"], "1kg": ["7.20","9.00"]},
         "Recommandée R2": { "20g": ["4.04","5.05"], "100g": ["4.96","6.20"], "250g": ["5.96","7.95"],"500g": ["6.84","8.55"],"1kg": ["7.80","9.75"]},
         "Recommandée R3": { "20g": ["4.96","6.20"], "100g": ["5.84","7.30"], "250g": ["6.88","8.60"], "500g": ["7.68","9.60"] ,"1kg": ["8.68","10.85"]},
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
    @order =  Order.find(params[:id])
  end
end
