class PaymentsController < ApplicationController
  before_action :set_order

  def new
    @pack = Pack.find(params[:pack_id])

  end

  def create
    @pack = Pack.find(params[:pack_id])
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )


    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @order.price_cents,
      description:  "Paiment pour une commande de timbres",
      currency:     @order.price.currency
    )


    @order.update(payment: charge.to_json, state: 'paid')
    redirect_to pack_order_path(@pack, @order)

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_pack_order_payment_path(@order.pack_id, @order)
  end

  private

  def set_order
    @order = current_user.orders.where(state: 'pending').find(params[:order_id])
  end
end
