class PaymentsController < ApplicationController
  before_action :set_cart

  def new
  end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )


    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @cart.orders.map{|o| o.price_cents}.sum,
      description:  "Paiment pour une commande de timbres",
      currency:     @cart.orders.first.price.currency
    )
    @cart.orders.each do |order|
       order.update(payment: charge.to_json, state: 'paid', cart_id: nil)
    end
    #TODO redirection to confirmation
    redirect_to @cart

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_pack_order_payment_path(@order.pack_id, @order)
  end

  private

  def set_cart
    @cart = current_user.cart
  end
end
