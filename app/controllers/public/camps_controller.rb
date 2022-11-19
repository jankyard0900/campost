class Public::CampsController < ApplicationController
  before_action :gatekeeper
  before_action :ensure_guest_user, only: [:new, :create, :edit, :update, :destroy]

  def new
    if admin_signed_in?
      redirect_to camps_path, alert: '管理者は投稿できません。'
    end
    @camp = Camp.new
    @areas = Area.all
  end

  def create
    @camp = Camp.new(camp_params)
    @camp.customer_id = current_customer.id
    if @camp.save
      redirect_to camp_path(@camp.id), notice: 'キャンプ場が作成できました！'
    else
      @areas = Area.all
      flash.now[:alert] = "作成できませんでした。もう一度やり直してください。"
      render :new
    end
  end

  def index
    @areas = Area.all
    @camps_all = Camp.all
    if params[:latest]
      @camps = Camp.latest.page(params[:page]).per(6)
    elsif params[:star_count]
      @camps = Camp.left_joins(:camp_reviews).group(:id).order("AVG(camp_reviews.rate) desc").page(params[:page]).per(6)
    else
      @camps = Camp.page(params[:page]).per(6)
    end
  end

  def show
    @camp = Camp.find(params[:id])
    @camp_reviews = @camp.camp_reviews
  end

  def edit
    @camp = Camp.find(params[:id])
    unless (@camp.customer == current_customer) || admin_signed_in?
      redirect_to camp_path(@camp.id), alert: '他のユーザーの投稿は編集できません。'
    end
    @areas = Area.all
  end

  def update
    @camp = Camp.find(params[:id])
    if params[:camp][:image_ids]
      params[:post][:image_ids].each do |image_id|
        @image = @camp.camp_images.find(image_id)
        @image.purge
      end
    end
    if @camp.update(camp_params)
      redirect_to camp_path(@camp.id), notice: '投稿を変更しました。'
    else
      @areas = Area.all
      flash.now[:alert] = "更新できませんでした。もう一度やり直してください。"
      render :edit
    end
  end

  def destroy
    @camp = Camp.find(params[:id])
    if @camp.destroy
      redirect_to camps_path, notice: '投稿を削除しました。'
    else
      @areas = Area.all
      flash.now[:alert] = "削除できませんでした。もう一度やり直してください。"
      render :edit
    end
  end

  def search
    @areas = Area.all
    if params[:area_id]
      @area = Area.find(params[:area_id])
      @area_camps = @area.camps
      @camps_count = @area.camps.count
    else
      redirect_to camps_path
    end
    if params[:latest]
      @area_camps = @area_camps.latest.page(params[:page]).per(6)
    elsif params[:star_count]
      @area_camps = @area_camps.left_joins(:camp_reviews).group(:id).order("AVG(camp_reviews.rate) desc").page(params[:page]).per(6)
    else
      @area_camps = @area_camps.page(params[:page]).per(6)
    end
  end

  private

  def camp_params
    params.require(:camp).permit(:name, :area_id, :name, :address, :access_method, :parking, :vehicle, :close_facilities, :hot_spring,  :in_site_facilities, :fee_information, camp_images: [])
  end
end
