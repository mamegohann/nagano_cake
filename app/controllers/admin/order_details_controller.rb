class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    if order_detail.status == "production"
      order_detail.order.update(status: "production")
    elsif order_detail.order.order_details.all?{|order_detail| order_detail.status == "complete_production"}
      order_detail.order.update(status: "shipping_preparation")
    end
    redirect_to admin_order_path(order_detail.order_id)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:status)
  end
end
