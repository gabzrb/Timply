class CartsController < ApplicationController
  def show
    @user_cart = current_user.cart
    @orders = @user_cart.orders
    @total = @user_cart.orders.map{|o| o.price}.sum
    @total_cent = @user_cart.orders.map{|o| o.price_cents}.sum
    @sku = @user_cart.orders.map{|o| o.id}.join('_').prepend("TimplyOrder_")

    if @orders.length > 0
      session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: @sku,
        images: [Cart::LOGO],
        amount: @total_cent,
        currency: 'eur',
        quantity: 1
      }],
      success_url: cart_confirmation_url,
      cancel_url: cart_url
      )

      @user_cart.update(checkout_session_id: session.id)
    else
      @user_cart.update(checkout_session_id: nil)
    end
  end

  def cart_confirmation
    @cart = current_user.cart
    @total = @cart.orders.map{|o| o.price_cents}.sum / 100

    @cart.orders.each do |order|
       order.update!(payment: @cart.checkout_session_id, state: 'paid', cart_id: nil)
    end

    redirect_to dashboard_path if @cart.orders.size == 0
  end
end
