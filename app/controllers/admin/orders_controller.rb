class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @order_details = OrderDetail.where(order_id: params[:id])
    @order = Order.find(params[:id])
    @total_price = calculate(@order)
  end
  
  def calculate(total_price)
    @total_price = 0
    @order_details.each {|order_detail|
    subtotal = order_detail.tax_price * order_detail.quantity
    @total_price += subtotal
    }
    return @total_price
  end

  def update
    order_details = OrderDetail.where(order_id: params[:id])
    order = Order.find(params[:id])
    order.update(order_params)
    if order.status == "confirm_payment"
      order_details.update_all(status: "not_production")
    end
    redirect_to admin_order_path(order.id)
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end

end
