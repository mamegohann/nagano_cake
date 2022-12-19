class Public::OrdersController < ApplicationController
  
  def new
  	@order = Order.new
	end
	
	def check
		@order = Order.new(order_params)
    @order.postal_code = @address.postal_code
    @order.address     = @address.address
    @order.name        = @address.name
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
   
    if params[:order][:destination] == "destination"
      @order.postal_code = current_customer.postal_code
      @order.address     = current_customer.address
      @order.name        = current_customer.name

    else params[:order][:destination] == "destinations"
      ship = ShippingAddress.find(params[:order][:destination])
      @order.postal_code = ship.destination_postal_code
      @order.address     = ship.destination_address
      @order.name        = ship.destination_name
    end
	end
	
	def over
	end

	def create
    @order = current_customer.orders.new(order_params)
    @order.save
    @cart_items = current_cart
    @cart_items.all_destroy# 注文確定後カートを空にす
  end
  
  def index
    @orders = current_customer.orders
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  private

  def order_params
    params.require(:order).permit(:quantity, :item_id, :payment_method, :destination_postal_code, :destination_address, :destination_name, :total_price)
  end
  
  def destination_params
    params.require(:order).permit(:destination_address, :destination_name, :destination_postal_code)
  end
  
end
