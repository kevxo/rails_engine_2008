Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/most_revenue', to: 'intelligence#most_revenue'
        get '/most_items', to: 'intelligence#most_items_sold'
      end

      namespace :items do
        get '/:id/merchants', to: 'merchants#index'
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end

      resources :merchants
      get '/revenue', to: 'merchants#revenue_across_date'

      resources :items
    end
  end
end
