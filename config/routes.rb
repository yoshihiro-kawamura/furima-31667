Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :buys, only: [:create, :index]
    collection do
      get 'search'
    end
    resources :comments, only: [:create]
  end
end

# get 'messages/new'
# resources :messages, only: [:create]
# collection do
#   get 'new'
# end