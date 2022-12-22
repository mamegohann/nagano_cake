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
      shipping = Destination.find(params[:order][:destination])
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
    flash[:notice] = "ご注文が確定しました。"
    redirect_to over_orders_path
    
    if params[:order][:address] == "new_address"
      current_customer.destination.new(destination_params)
      current_customer.destination.save
    end

    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      order = Order.new(order_id: @order.id)
      order.price = cart_item.item.price
      order.quantity = cart_item.quantity
      order.item_id = cart_item.item_id
      order.save
    end
    @cart_items.all_destroy
    redirect_to over_orders_path
  end
  
  def all_destroy
    cart_items = CartItem.all
    cart_items.destroy_all
    render 'over'
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

  def destination_params
    params.require(:destination).permit(:address, :name, :postal_code)
  end

end
