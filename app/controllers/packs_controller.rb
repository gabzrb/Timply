PCK = {"Lettre Verte": ["0.79", "0.88"],
       "Lettre Prioritaire": ["0.94","1.05"],
       "Lettre Suivie": ["1.29","1,45"],
       "Recommandés": ["3,98","4.18"]}


class PacksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @packs = Pack.all
  end

  def show
    @poids = ["20g", "100g", "250g", "500g", "3kg"]
    @pack = Pack.find(params[:id])
    @packs = Pack.where.not(id:@pack.id)
    @show_prices = [PCK[@pack.title.to_sym][0], PCK[@pack.title.to_sym][1]]
    @order = Order.new
  end
end
