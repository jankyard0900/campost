class Public::CampReviewsController < ApplicationController
  before_action :gatekeeper
  before_action :ensure_guest_user

  def new
    @camp = Camp.find(params[:camp_id])
    if admin_signed_in?
      redirect_to camp_path(@camp), alert: '管理者は投稿できません。'
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
      flash.now[:alert] = "投稿出来ませんでした。もう一度やり直してください。"
      render :new
    end
  end

  def destroy
    @camp_review = CampReview.find(params[:id])
    if (@camp_review.customer == current_customer) || admin_signed_in?
      @camp_review.destroy
      redirect_to request.referer, notice: 'レビューを削除しました。'
    else
      @camp = @camp_review.camp
      @camp_reviews = @camp.camp_reviews
      flash.now[:alert] = "他のユーザのレビューは削除出来ません。"
      render template: "public/camps/show"
    end
  end

  private

  def camp_review_params
    params.require(:camp_review).permit(:rate, :title, :review, review_camp_images: [])
  end
end
