class Public::CampsController < ApplicationController
  def new
    @camp = Camp.new
    @areas = Area.all
  end

  def create
    @camp = Camp.new(camp_params)
    @camp.customer_id = current_customer.id
    if @camp.save
      flash[:success] = "キャンプ場が作成できました！"
      redirect_to camps_path
    else
      @areas = Area.all
      render :new
    end
  end

  def index
    @camps = Camp.page(params[:page]).per(6)
  end

  def show
    @camp = Camp.find(params[:id])
  end

  def edit
    @camp = Camp.find(params[:id])
  end

  def update
  end

  def destroy
    @camp = Camp.find(params[:id])
    if @camp.destroy
      flash[:success] = "投稿を削除しました。"
      redirect_to camps_path
    else
      render :edit
    end
  end

  def search
  end

  private

  def camp_params
    params.require(:camp).permit(:name, :area_id, :name, :address, :access_method, :parking, :vehicle, :close_facilities, :hot_spring,  :in_site_facilities, :fee_information, camp_images: [])
  end
end
