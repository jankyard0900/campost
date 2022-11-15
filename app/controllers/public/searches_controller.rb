class Public::SearchesController < ApplicationController
  def search
    @range = params[:range]
    if @range == "キャンプ場"
      @camps = Camp.looks(params[:word])
    else
      @gears = Gear.looks(params[:word])
    end
  end
end
