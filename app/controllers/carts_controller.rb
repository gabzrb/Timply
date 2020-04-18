class CartsController < ApplicationController
  def show
    @user_cart = current_user.cart
    @orders = @user_cart.orders
    @total = @user_cart.orders.map{|o| o.price}.sum
    @total_cent = @user_cart.orders.map{|o| o.price_cents}.sum
    @sku = @user_cart.orders.map{|o| o.pack_sku}.join('_')
  end
end
