Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # namespace :api do 
  #   namespace :v1 do
  #     resources :merchants, only: [:index, :show] do 

  #       get 'items', on: :member, to: "merchants_items#index"
  #     end
  #   end
  # end

  # namespace :api do
  #   namespace :v1 do
  #     resources :items, only: [:index, :show]
  #   end
  # end
#   get "/api/v1/items/:id/merchant", to: "api/v1/items/merchants#show"

#   namespace :api do
#     namespace :v1 do
#       resources :merchants, only: [:index, :show] do
#         resources :items, module: :merchants, only: [:index]
#       end

#       resources :items, only: [:index, :show, :create, :update, :destroy] 
#     end 
#   end
# end 

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, module: :merchants, only: [:index]
      end

      resources :items, only: [:index, :show, :create, :update, :destroy] do
        get 'merchant', to: 'items/merchants#show', on: :member
      end
    end
  end
end 


