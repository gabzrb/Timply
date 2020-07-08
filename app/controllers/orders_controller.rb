PACKS =
{"Lettre Verte": { "20g": ["0.87", "0.97"],  "100g": ["1.74","1.94"], "250g": ["3.49", "3.88"], "500g": ["5.24","5.82"], "3kg": ["6.98","7.76"]},

         "Lettre Prioritaire": {"20g": ["1.04","1.16"], "100g": ["2.09","2.32"], "250g": ["4.17","4.64"], "500g": ["6.26", "6.96"], "3kg": ["8.35","9.28"]},

         "Lettre Prioritaire Internationale": { "20g": ["1.26","1.40"],  "100g":["2.52","2.80"], "250g":["6.30","7.00"], "500g": ["10.08", "11.20"],"2kg": ["17.64","19.60"], "3kg": ["30.24","33.60"]},

         "Lettre Suivie": {"20g": ["1.27" ,"1.42"], "100g": ["2.15" ,"2.39"], "250g": ["3.89", "4.33"], "500g": ["5.64","6.27"], "3kg": ["7.38","8.21"]},

         "Lettre Suivie Internationale": { "20g": ["'4.36","4.50"], "50g":["5.5","5.80"], "100g": ["5.5","5.80"], "250g":["11.54","13.60"], "500g": ["17.78","21.40"], "3kg": ["28.82","35.20"]},

         "Recommandée R1": { "20g": ["3.87","4.30"], "100g": ["4.95", "5.50"], "250g": ["6.03", "6.70"], "500g": ["7.06","7.85"], "1kg": ["8.10","9.00"], "2kg": ["9.63","10.70"], "3kg": ["10.73","11.93"]},
         "Recommandée R2": { "20g": ["4.54","5.05"], "100g": ["5.58","6.20"], "250g": ["6.70","7.45"],"500g": ["7.69","8.55"],"1kg": ["8.77","9.75"], "2kg": ["10.26","11.40"], "3kg": ["11.36","12.63"]},
         "Recommandée R3": { "20g": ["5.58","6.20"], "100g": ["6.57","7.30"], "250g": ["7.74","8.60"], "500g": ["8.64","9.60"] ,"1kg": ["9.76","10.85"], "2kg": ["11.34","12.60"], "3kg": ["12.40","13.78"]},
         "Recommandée R1 Internationale":  { "20g": ["5.5","5.80"], "50g": ["6.75","7.10"], "100g": ["6.75","7.10"], "250g": ["10.45","11"],"500g": ["14.15","14.90"],"1kg": ["21.55","22.70"],"2kg": ["21.55","22.70"] , "3kg": ["21.55","22.70"] },
         "Recommandée R2 Internationale":  { "20g": ["6.46","6.80"], "50g": ["7.69","8.10"], "100g": ["7.69","8.10"], "250g": ["11.4","12"], "500g": ["15.1","15.9"],"1kg": ["22.5","23.70"],"2kg": ["22.5","23.70"], "3kg": ["22.5","22.70"] }}



class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy, :edit, :update]
  before_action :check_admin, only: [:index]

  def index
    @orders = Order.all.reverse
    @query = params[:query] == '' ? nil : params[:query]
    @status = params[:status] == 'all' ? nil : params[:status]
    if @query && @status
      @orders = Order.global_search(@query).select { |o| o.state == @status }.sort_by(&:updated_at)
    elsif @query
      @orders = Order.global_search(@query).sort_by(&:updated_at)
    elsif @status
      @orders.select! { |o| o.state == @status }.sort_by(&:updated_at)
    end
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
