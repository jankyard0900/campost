class Public::CustomersController < ApplicationController
  before_action :a

  def show
    @customer = Customer.find(params[:id])
    @camp_reviews = @customer.camp_reviews
    @gear_reviews = @customer.gear_reviews
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path, notice: "プロフィールの更新が完了しました。"
    else
      render :edit
    end
  end

  def withdraw
    @customer = Customer.find(params[:id])
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行致しました。"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :is_active)
  end

  def a
    if !customer_signed_in? && !admin_signed_in?
      redirect_to camps_path
    end
  end
end
