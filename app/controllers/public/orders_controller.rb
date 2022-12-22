class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
 
  def new
    @order = Order.new
    @destination = Destination.where(customer:current_customer)
  end

  def check
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
    @total_price = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @billing = @total_price + @order.postage

    if params[:order][:address] == "address"
      @order.postal_code = current_customer.postal_code
      @order.address     = current_customer.address
      @order.name        = current_customer.name

    elsif params[:order][:address] == "destination_address"
      shipping = Address.find(params[:order][:destination_address])
      @order.postal_code = shipping.postal_code
      @order.address     = shipping.address
      @order.name        = shipping.name

    elsif params[:order][:address] == "new_address"
      @order.postal_code = params[:order][:postal_code]
      @order.address     = params[:order][:address]
      @order.name        = params[:order][:name]
    end
  end

  def over
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.save
    @cart_items = current_cart
    @cart_items.all_destroy
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  private

  def order_params
    params.require(:order).permit(:quantity, :item_id, :payment_method, :postal_code, :address, :name, :total_price)
  end

  def address_params
    params.require(:order).permit(:address, :name, :postal_code)
  end

end
