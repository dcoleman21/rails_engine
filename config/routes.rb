Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/:id/merchant', to: 'merchants#show'
      end

      namespace :merchants do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/:id/items', to: 'items#index'
        get '/most_revenue', to: 'business_intel#most_revenue'
      end

      resources :items
      resources :merchants
    end
  end
end
