class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_user
  before_action :ensure_correct_customer

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

  def unsubscribe
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: '変更を保存しました！'
    else
      flash.now[:alert] = "更新できませんでした。もう一度やり直してください。"
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

  def ensure_correct_customer
    @customer =  Customer.find(params[:id])
    unless (@customer == current_customer)
      redirect_to customer_path(current_customer), alert: '他のユーザーの画面は表示できません。'
    end
  end
end
