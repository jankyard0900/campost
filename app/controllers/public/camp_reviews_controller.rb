class Public::CampReviewsController < ApplicationController
  def new
    @camp = Camp.find(params[:camp_id])
    @camp_review = CampReview.new
  end

  def create
    @camp = Camp.find(params[:camp_id])
    @camp_review = current_customer.camp_reviews.new(camp_review_params)
    @camp_review.camp_id = @camp.id
    if @camp_review.save
      flash[:success] = "レビューを投稿しました。"
      redirect_to camp_path(@camp.id)
    else
      render :new
    end
  end

  def destroy
    CampReview.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def camp_review_params
    params.require(:camp_review).permit(:rate, :title, :review, review_camp_images: [])
  end
end
