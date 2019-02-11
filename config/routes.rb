Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'welcome#index', as: "welcome"

namespace :merchant do
  resources :items, except: [:show]
end

namespace :admin do
  resources :merchants, only: [:show]
	resources :items, except: [:show]
	resources :users, only: [:show, :index, :edit, :update]
end

get '/register', to: 'users#new'
get '/merchants', to: 'users#index'
get '/merchants/:id', to: 'users#show'

get '/login', to: 'sessions#new'
post '/login', to: 'sessions#create'
delete '/logout', to: 'sessions#destroy'

get '/dashboard', to: 'merchants#show'
get '/dashboard/items', to: 'merchant/items#index'
get '/profile', to: 'users#show'
get '/profile/edit', to: 'users#edit'
#get '/profile/orders', to: 'user/orders#index'
#get '/profile/orders/:id', to: 'user/orders#show'

resources :items, only: [:show, :index, :edit, :new, :destroy]
resources :users, only: [:index, :create, :edit]

end
