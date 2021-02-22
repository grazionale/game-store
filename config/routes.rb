Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth/v1/user'

  namespace :admin do
    namespace :v1 do
      get "home" => "home#index"
      resources :categories
      resources :users
      resources :coupons
      resources :system_requirements
      resources :products
      
      # shallow faz que adicione o game_id apenas nas rotas necessárias
      # GET POST /admin/v1/games/:game_id/licenses
      # GET PATCH DELETE /admin/v1/licenses/:id
      resources :games, only: [], shallow: true do 
        resources :licenses 
      end
    end
  end

  namespace :storefront do
    namespace :v1 do
      get "home" => "home#index"
    end
  end
end
