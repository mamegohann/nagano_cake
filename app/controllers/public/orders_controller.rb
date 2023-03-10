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

    @order.total_price = @total_price

    if params[:order][:select_address] == "address"
      @order.postal_code = current_customer.postal_code
      @order.address     = current_customer.address
      @order.name        = current_customer.last_name + current_customer.first_name

    elsif params[:order][:select_address] == "destination"
      @destination = Destination.find(params[:order][:destination_id])
      @order.postal_code = @destination.destination_postal_code
      @order.address     = @destination.destination_address
      @order.name        = @destination.destination_name

    elsif params[:order][:select_address] == "new_address"
      if params[:order][:postal_code] == "" or params[:order][:address] == "" or params[:order][:name] == ""
         flash[:alert] = "正しい配送先を入力してください。"
        redirect_to request.referer

      elsif @destination = current_customer.destinations.new
        @destination.destination_postal_code = params[:order][:postal_code]
        @destination.destination_address     = params[:order][:address]
        @destination.destination_name        = params[:order][:name]
        @destination.customer_id = current_customer.id
        if @destination.save
          @order.postal_code = @destination.destination_postal_code
          @order.address     = @destination.destination_address
          @order.name        = @destination.destination_name
        end
      end
    end
    @order_new = Order.new
  end

  def over
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.tax_price = cart_item.item.add_tax_price
        @order_detail.quantity = cart_item.quantity
        @order_detail.item_id = cart_item.item_id
        @order_detail.order_id =  @order.id
        @order_detail.save
      end

    @cart_items.destroy_all
    redirect_to over_orders_path

  end

  def index
    @orders = current_customer.orders.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :quantity, :item_id, :payment_method, :postal_code, :address, :name, :total_price)
  end

end