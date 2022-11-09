Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # 会員用
  scope module: :public do
    get 'searches/search'=>'searches#search', as: 'search'

    resources :camp_reviews, only: [:new, :create, :destroy]

    resources :gears, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :gear_reviews, only: [:new, :create, :destroy]
    end
    get 'gears/search'=>'gears#search', as: 'gear_search'

    resources :camps, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :camp_reviews, only: [:new, :create, :destroy]
    end
    get 'camps/search'=>'camps#search', as: 'camp_search'

    get 'customers/my_page'=>'customers#show',as: 'my_page'
    get 'customers/infomation/edit'=>'customers#edit',as: 'edit_infomation'
    patch 'customers/infomation'=>'customers#update',as: 'infomation'
    get 'customers/unsubscribe'=>'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdraw'=>'customers#withdraw', as: 'withdraw'

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
