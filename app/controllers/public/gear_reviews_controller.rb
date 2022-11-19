class Public::GearReviewsController < ApplicationController
  before_action :gatekeeper
  before_action :ensure_guest_user

  def new
    @gear = Gear.find(params[:gear_id])
    if admin_signed_in?
      redirect_to gear_path(@gear), alert: '管理者は投稿できません。'
    end
    @gear_review = GearReview.new
  end

  def create
    @gear = Gear.find(params[:gear_id])
    @gear_review = current_customer.gear_reviews.new(gear_review_params)
    @gear_review.gear_id = @gear.id
    if @gear_review.save
      redirect_to gear_path(@gear.id), notice: 'レビューを投稿しました。'
    else
      flash.now[:alert] = "投稿出来ませんでした。もう一度やり直してください。"
      render :new
    end
  end

  def destroy
    GearReview.find(params[:id]).destroy
    redirect_to request.referer, notice: 'レビューを削除しました。'
  end

  private

  def gear_review_params
    params.require(:gear_review).permit(:rate, :title, :review, review_gear_images: [])
  end
end
