class Public::GearsController < ApplicationController
  def new
    @gear = Gear.new
    @categories = Category.all
  end

  def create
    @gear = Gear.new(gear_params)
    @gear.customer_id = current_customer.id
    if @gear.save
      flash[:success] = "キャンプギアが作成できました！"
      redirect_to gears_path
    else
      @categories = Category.all
      render :new
    end
  end

  def index
    @gears = Gear.page(params[:page]).per(6)
  end

  def show
    @gear = Gear.find(params[:id])
    @gear_reviews = @gear.gear_reviews
  end

  def edit
    @gear = Gear.find(params[:id])
    @categories = Category.all
  end

  def update
    @gear = Gear.find(params[:id])
    if @gear.update(gear_params)
      flash[:success] = "投稿を変更しました。"
      redirect_to gear_path(@gear.id)
    else
      @categories = Category.all
      render :edit
    end
  end

  def destroy
    @gear = Gear.find(params[:id])
    if @gear.destroy
      flash[:success] = "投稿を削除しました。"
      redirect_to gears_path
    else
      @categories = Category.all
      render :edit
    end
  end

  def search
  end

  private

  def gear_params
    params.require(:gear).permit(:name, :price, :brand_name, :category_id, gear_images: [])
  end
end
