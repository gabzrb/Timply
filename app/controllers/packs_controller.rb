PCK = {"Lettre Verte": ["0.87", "0.97"],
       "Lettre Prioritaire": ["0.94","1.05"],
       "Lettre Suivie": ["1.27","1.45"],
       "Recommandées": ["3.87","4.30"]}


class PacksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

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
