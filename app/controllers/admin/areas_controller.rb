class Admin::AreasController < ApplicationController
  before_action :authenticate_admin!

  def edit
    @area = Area.find(params[:id])
  end

  def create
    @area = Area.new(area_params)
    if @area.save
      redirect_to admin_tags_path, notice: "エリアの登録が完了しました。"
    else
      @areas = Area.all
      @categories = Category.all
      @category = Category.new
      flash.now[:alert] = "エリアの登録に失敗しました。もう一度やり直してください。"
      render template: "admin/tags/index"
    end
  end

  def update
    @area = Area.find(params[:id])
    if @area.update(area_params)
      redirect_to admin_tags_path, notice: "エリアの更新が完了しました。"
    else
      flash.now[:alert] = "エリアの更新が出来ませんでした。もう一度やり直してください。"
      render 'edit'
    end
  end

  private

  def area_params
    params.require(:area).permit(:name)
  end
end
