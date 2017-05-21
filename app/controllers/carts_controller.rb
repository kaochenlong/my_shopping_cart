class CartsController < ApplicationController

  def add
    @cart.add_item(params[:id])
    session[:cart9487] = @cart.to_hash
    redirect_to products_path, notice: "已放入購物車"
  end

end
