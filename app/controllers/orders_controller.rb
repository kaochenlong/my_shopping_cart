class OrdersController < ApplicationController
  def create
    @order = Order.new(order_params)

    @cart.items.each do |item|
      @order.order_items.build(product: item.product,
                               price: item.product.price,
                               quantity: item.quantity)
    end

    if @order.save
      # 1. 付錢
      #
      # 2. 清空購物車
      session[:cart9487] = nil

      # 2.5 寄信通知
      OrderMailer.order_confirm(@order).deliver_now

      # 3. 走回 product 頁面
      redirect_to products_path, notice: "感謝大爺!"
    else
      render "carts/checkout"
    end
  end

  private
  def order_params
    params.require(:order).permit(:recipient, :tel, :email)
  end
end
