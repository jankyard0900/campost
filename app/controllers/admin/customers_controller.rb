class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
    @camp_reviews = @customer.camp_reviews
    @gear_reviews = @customer.gear_reviews
  end

  def camp
    @customer = Customer.find(params[:id])
    @camps = @customer.camps
    @gears = @customer.gears
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer.id), notice: "会員情報を編集しました。"
    else
      flash.now[alert] = "会員情報を更新できませんでした。"
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :is_active)
  end
end
