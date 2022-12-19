class Public::DestinationsController < ApplicationController

  def index
    @destination = Destination.new
    @destinations = Destination.all
  end

  def edit
    @destination = Destination.find(params[:id])
  end

  def create
    destination = Destination.new
    destination.customer_id = current_customer.id
    destination.save
    redirect_to destinations_path
  end

  def update
    destination = Destination.find(params[:id])
    destination.update
    redirect_to destinations_path
  end

  def destroy
    destination = Destination.find(params[:id])
    destination.destroy
    redirect_to destinations_path
  end

end
