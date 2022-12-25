class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def quit
  end

  def out
    @customer = current_customer
    @customer.update(status: true)

    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  def update

  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :tel_number, :email)
  end

end
