class CartsController < ApplicationController
  def add
    @cart.add_item(params[:id])
    session[:cart9487] = @cart.to_hash
    redirect_to products_path, notice: "已放入購物車"
  end

  def checkout
    @order = Order.new
  end

  def destroy
    session[:cart9487] = nil
    redirect_to products_path, notice: "購物車已清除!"
  end
end
