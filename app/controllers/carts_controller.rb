class CartsController < ApplicationController
  def show
    @user_cart = current_user.cart
  end
end
