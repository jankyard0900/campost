class Public::SearchesController < ApplicationController
  def search
    @areas = Area.all
    @categories = Category.all
    @word = params[:word]
    @range = params[:range]
    if @range == "キャンプ場"
      @camps = Camp.looks(params[:word]).page(params[:page]).per(6)
    else
      @gears = Gear.looks(params[:word]).page(params[:page]).per(6)
    end
  end
end
