class Public::GearsController < ApplicationController
  before_action :gatekeeper
  before_action :ensure_guest_user,  only: [:new, :create, :edit, :update, :destroy]

  def new
    if admin_signed_in?
      redirect_to gears_path, alert: '管理者は投稿できません。'
    end
    @gear = Gear.new
    @categories = Category.all
  end

  def create
    @gear = Gear.new(gear_params)
    @gear.customer_id = current_customer.id
    if @gear.save
      redirect_to gear_path(@gear.id), notice: 'キャンプギアが作成できました！'
    else
      @categories = Category.all
      flash.now[:alert] = "作成できませんでした。もう一度やり直してください。"
      render :new
    end
  end

  def index
    @categories = Category.all
    @gears_all = Gear.all
    if params[:latest]
      @gears = Gear.latest.page(params[:page]).per(6)
    elsif params[:star_count]
      @gears = Gear.left_joins(:gear_reviews).group(:id).order("AVG(gear_reviews.rate) desc").page(params[:page]).per(6)
    else
      @gears = Gear.page(params[:page]).per(6)
    end
  end

  def show
    @gear = Gear.find(params[:id])
    @gear_reviews = @gear.gear_reviews
  end

  def edit
    @gear = Gear.find(params[:id])
    @categories = Category.all
    unless (@gear.customer == current_customer) || admin_signed_in?
      redirect_to gear_path(@gear.id), alert: '他のユーザーの投稿は編集できません。'
    end
  end

  def update
    @gear = Gear.find(params[:id])
    if @gear.update(gear_params)
      redirect_to gear_path(@gear.id), notice: '投稿を変更しました。'
    else
      @categories = Category.all
      flash.now[:alert] = "更新できませんでした。もう一度やり直してください。"
      render :edit
    end
  end

  def destroy
    @gear = Gear.find(params[:id])
    if (@gear.customer == current_customer) || admin_signed_in?
      @gear.destroy
      redirect_to gears_path, notice: '投稿を削除しました。'
    else
      @categories = Category.all
      flash.now[:alert] = "削除できませんでした。もう一度やり直してください。"
      render :edit
    end
  end

  def search
    @categories = Category.all
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @category_gears = @category.gears
      @gears_count = @category.gears.count
    else
      redirect_to gears_path
    end
    if params[:latest]
      @category_gears = @category_gears.latest.page(params[:page]).per(6)
    elsif params[:star_count]
      @category_gears = @category_gears.left_joins(:gear_reviews).group(:id).order("AVG(gear_reviews.rate) desc").page(params[:page]).per(6)
    else
      @category_gears = @category_gears.page(params[:page]).per(6)
    end
  end

  private

  def gear_params
    params.require(:gear).permit(:name, :price, :brand_name, :category_id, gear_images: [])
  end
end
