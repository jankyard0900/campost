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
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def search
  end

  private

  def gear_params
    params.require(:gear).permit(:name, :price, :brand_name, :category_id, gear_images: [])
  end
end
