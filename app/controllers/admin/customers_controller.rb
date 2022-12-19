class Admin::CustomersController < ApplicationController
  before_action :logged_in_customer, only: [:index, :show, :edit, :update]
  before_action :correct_customer,   only: [:edit, :update]

  def index
    @customers = Customer.all
  end

  def show

  end

  def edit
    
  end

  def update

  end

end
