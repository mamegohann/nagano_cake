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
    resources :orders
    resources :destinations
  end
  
  
  
  
end
