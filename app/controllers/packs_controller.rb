class PacksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @packs = Pack.all
  end

  def show
    @poids = ["20g", "100g", "250g", "500g", "3kg"]
    @pack = Pack.find(params[:id])
    @packs = Pack.where.not(id:@pack.id)
    @order = Order.new
  end
end
