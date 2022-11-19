class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_tags_path, notice: "カテゴリの登録が完了しました。"
    else
      @areas = Area.all
      @area = Area.new
      @categories = Category.all
      flash.now[:alert] = "カテゴリの登録に失敗しました。もう一度やり直してください。"
      render template: "admin/tags/index"
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_tags_path, notice: "カテゴリの更新が完了しました。"
    else
      flash.now[:alert] = "カテゴリの更新が出来ませんでした。もう一度やり直してください。"
      render 'edit'
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
