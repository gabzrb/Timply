class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :mentionslegales, :apropos]
  def home
  end

  def dashboard
    @orders = Order.where(id: current_user.order_ids).reverse
    @packs = Pack.where(id: current_user.order_ids)
    @all_reduction = 0
    if @orders
      @orders.each do |order|
        (@all_reduction += order.reduction.to_f) if order.state == 'paid'
      end
    end
  end

  def mentionslegales
  end

  def apropos
  end
end
