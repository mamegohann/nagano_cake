class Public::OrdersController < ApplicationController
  
  def new
  end
  
  def check
  end
  
  def over
  end
  
  def create
  end
  
  def index
  end
  
  def show
  end
  
  private
  
  def order_params
    params.require(:order).permit(:quantity,:item_id)
  end
  
end
