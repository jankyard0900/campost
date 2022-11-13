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
      flash[:success] = "投稿を変更しました。"
      redirect_to camp_path(@camp.id)
    else
      @areas = Area.all
      render :edit
    end
  end

  def destroy
    @camp = Camp.find(params[:id])
    if @camp.destroy
      flash[:success] = "投稿を削除しました。"
      redirect_to camps_path
    else
      @areas = Area.all
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
