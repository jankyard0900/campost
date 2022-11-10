class Admin::AreasController < ApplicationController
  def edit
    @area = Area.find(params[:id])
  end

  def create
    @area = Area.new(area_params)
    @area.save
    redirect_to admin_tags_path, notice: "エリアの登録が完了しました。"
  end

  def update
    @area = Area.find(params[:id])
    if @area.update(area_params)
      redirect_to admin_tags_path, notice: "エリアの更新が完了しました。"
    else
      render 'edit'
    end
  end

  private

  def area_params
    params.require(:area).permit(:name)
  end
end
