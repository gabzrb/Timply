
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :mentionslegales, :apropos, :conditionsgenerales,]

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
      @all_reduction = @all_reduction.round(2)
    end
  end


  def tracking
  end

  def trackingresult
    @api_key = 'vsZ5sdqwFp6Lp6H2qNHuqjwHJ4LtZEpbmBhoa+1kOUJ0W9SHAnM6dgz6LH6dIkI6'
    url = "https://api.laposte.fr/suivi/v1/#{params[:track]}"
    response = RestClient::Request.execute(method: :get, url: url,
                                           headers: {api_key: @api_key})
  end

  def mentionslegales
  end

  def apropos
  end

  def conditionsgenerales
  end

  def nostarif
  end
end
