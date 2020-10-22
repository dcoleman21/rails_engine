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
        get '/most_items', to: 'business_intel#most_items'
        get '/:id/revenue', to: 'business_intel#merchant_revenue'
      end

      get '/revenue', to: 'revenue#date_range'
      resources :items
      resources :merchants
    end
  end
end
