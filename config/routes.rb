Rails.application.routes.draw do
  
  
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  devise_for :customers,skip: [:passwords],controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_for :admin,skip: [:registrations, :passwords],controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: 'public' do
    root to: "homes#top"
    get 'about' => "homes#about"
    resources :items, only: [:index, :show]
  end
  
end
