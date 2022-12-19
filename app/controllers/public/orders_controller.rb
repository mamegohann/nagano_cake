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
   
    if params[:order][:addresses] == "addresses"
      @order.postal_code = current_customer.postal_code
      @order.address     = current_customer.address
      @order.name        = current_customer.name

    else params[:order][:addresses] == "destinations"
      ship = ShippingAddress.find(params[:order][:destinations])
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
    params.require(:order).permit(:quantity, :item_id, :payment_method, :postal_code, :address, :name, :total_price)
  end
  
  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end
  
end
