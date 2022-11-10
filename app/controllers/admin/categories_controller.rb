class Admin::CategoriesController < ApplicationController
  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to admin_tags_path, notice: "カテゴリの登録が完了しました。"
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_tags_path, notice: "カテゴリの更新が完了しました。"
    else
      render 'edit'
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
