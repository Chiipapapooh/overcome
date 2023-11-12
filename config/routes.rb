Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
scope module: :public do
    root 'homes#top'
    get '/homes/about' => "homes#about", as: 'about'
    get 'customers/mypage' => 'customers#show', as: 'mypage'
    # customers/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
    patch 'customers/information' => 'customers#update', as: 'update_information'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    put 'customers/information' => 'customers#update'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    
    resources :posts, only: [:new, :index, :create, :show, :edit, :update, :destroy]
    resources :news_letters, only: [:index, :create, :edit, :update, :destroy]
    
  end
    
# 管理者用
# URL /admin/sign_in ...
devise_for :admin, controllers: {
  sessions: "admin/sessions"
}
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    get 'search' => 'homes#search', as: 'search'
    get 'customers/:customer_id/orders' => 'orders#index', as: 'customer_orders'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :posts, only: [:index, :create, :edit, :update, :destroy]
    resources :news_letters, only: [:index, :create, :edit, :update, :destroy]
    resources :genres, only: [:show], as: "customers_genres", path: "customers/genres"
end

end 