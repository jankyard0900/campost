class Public::GearReviewsController < ApplicationController
  def new
    @gear = Gear.find(params[:gear_id])
    @gear_review = GearReview.new
  end

  def create
    @gear = Gear.find(params[:gear_id])
    @gear_review = current_customer.gear_reviews.new(gear_review_params)
    @gear_review.gear_id = @gear.id
    if @gear_review.save
      flash[:success] = "レビューを投稿しました。"
      redirect_to gear_path(@gear.id)
    else
      render :new
    end
  end

  def destroy
    GearReview.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def gear_review_params
    params.require(:gear_review).permit(:rate, :title, :review, review_gear_images: [])
  end
end
