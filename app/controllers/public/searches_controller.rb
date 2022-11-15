class Public::SearchesController < ApplicationController
  def search
    @areas = Area.all
    @categories = Category.all
    @word = params[:word]
    @range = params[:range]
    if @range == "キャンプ場"
      @camps = Camp.looks(params[:word]).page(params[:page]).per(6)
      if params[:latest]
        @camps = @camps.latest.page(params[:page]).per(6)
      elsif params[:star_count]
        @camps_count = @camps.count
        @camps = @camps.left_joins(:camp_reviews).group(:id).order("AVG(camp_reviews.rate) desc").page(params[:page]).per(6)
      else
        @camps = @camps.page(params[:page]).per(6)
      end
    else
      @gears = Gear.looks(params[:word]).page(params[:page]).per(6)
    end
  end
end
