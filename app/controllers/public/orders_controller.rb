class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end
  
  def check
    @cart_items = current_cart
    @order = Order.new(order_params)
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
  end
  
  def over
  end
  
  def create
    @order = current_customer.orders.new(order_params)
    @order.save
    @cart_items = current_cart
    @cart_items.all_destroy# 注文確定後カートを空にする
  end
  
  def index
    @orders = current_customer.orders
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  private
  
  def order_params
  params.require(:order).permit(:quantity, :item_id, :payment_method)
  end
  
end
