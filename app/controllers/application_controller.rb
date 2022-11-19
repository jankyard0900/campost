class ApplicationController < ActionController::Base
  protected

  def gatekeeper
    if !customer_signed_in? && !admin_signed_in?
      redirect_to root_path, alert: '新規会員登録またはログインしてください。'
    end
  end

  def ensure_guest_user
    if customer_signed_in? && (current_customer.name == "ゲストユーザー")
      redirect_to camps_path, alert: 'ゲストユーザーはこの画面はご利用できません。'
    end
  end
end
