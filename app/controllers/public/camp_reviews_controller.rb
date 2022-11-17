class Public::CampReviewsController < ApplicationController
  before_action :gatekeeper
  before_action :ensure_guest_user

  def new
    @camp = Camp.find(params[:camp_id])
    if admin_signed_in?
      redirect_to camp_path(@camp), notice: '管理者は投稿できません。'
    end
    @camp_review = CampReview.new
  end

  def create
    @camp = Camp.find(params[:camp_id])
    @camp_review = current_customer.camp_reviews.new(camp_review_params)
    @camp_review.camp_id = @camp.id
    if @camp_review.save
      redirect_to camp_path(@camp.id), notice: 'レビューを投稿しました。'
    else
      render :new
    end
  end

  def destroy
    CampReview.find(params[:id]).destroy
    redirect_to request.referer, notice: 'レビューを削除しました。'
  end

  private

  def camp_review_params
    params.require(:camp_review).permit(:rate, :title, :review, review_camp_images: [])
  end
end
