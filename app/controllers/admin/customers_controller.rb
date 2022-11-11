class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer.id), notice: "会員情報を編集しました。"
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :is_active)
  end
end
