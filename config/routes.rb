Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :customer do
  post 'cusotmers/guest_sign_in'=>'public/sessions#guest_sign_in'
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # 会員用
  scope module: :public do
    get 'searches/search'=>'searches#search', as: 'search'

    get 'gears/search'=>'gears#search', as: 'gear_search'
    resources :gears, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :gear_reviews, only: [:new, :create, :destroy]
    end

    get 'camps/search'=>'camps#search', as: 'camp_search'
    resources :camps, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :camp_reviews, only: [:new, :create, :destroy]
    end

    resources :customers, only: [:show, :edit, :update]
    get 'customers/:id/unsubscribe'=>'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/:id/withdraw'=>'customers#withdraw', as: 'withdraw'

    root :to =>"homes#top"
  end

  # 管理者用
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]

    resources :tags, only: [:index]

    resources :categories, only: [:create, :edit, :update]

    resources :areas, only: [:create, :edit, :update]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
