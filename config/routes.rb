Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords],controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin,skip: [:registrations, :passwords],controllers: {
    sessions: "admin/sessions"
  }

  # 会員側のルーティング設定
  scope module: :public do
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index,:create,:update,:destroy] do
      collection do
        delete "all_destroy"   #パスが　all_destroy_cart_items_path, method: :delete　となる
      end
    end
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :orders,only: [:new,:index,:show,:create] do
        collection do
          post 'check'
          get 'over'
        end
    end
    resources :destinations
    resource :customers, only: [:show] do
      collection do
        get 'quit'
        patch 'out'
      end
    end
  end

  namespace :admin do
    resources :genres
    resources :items, only: [:index,:new,:create,:show,:edit,:update,]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
    get 'orders' => 'homes#top'
    resources :customers, only: [:index,:show,:edit,:update]
  end

end
