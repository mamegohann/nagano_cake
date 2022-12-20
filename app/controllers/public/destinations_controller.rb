class Public::DestinationsController < ApplicationController
  
  def index
    @destination = Destination.new
    @destinations = Destination.all
  end

  def edit
    @destination = Destination.find(params[:id])
  end
  
  def create
    destination = Destination.new(destination_params)
    destination.customer_id = current_customer.id
    destination.save
    redirect_to destinations_path
  end
  
  def update
    destination = Destination.find(params[:id])
    destination.update(destination_params)
    redirect_to destinations_path
  end
  
  def destroy
    destination = Destination.find(params[:id])
    destination.destroy
    redirect_to destinations_path
  end
  
  private
  
  def destination_params
    params.require(:destination).permit(:destination_address, :destination_name, :destination_postal_code)
  end
end
