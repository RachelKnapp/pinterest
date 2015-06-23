Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  get 'items' => 'items#index', as: :items_path
  post 'items' => 'items#create', as: :create_item
  get 'items/:id' => 'items#show', as: :item

  post 'items/:id/buy' => 'items#buy', as: :buy_item

  root to: 'main#index'

  # resources :items
  # The above line equals the below 7
  # get 'items' => 'items#index'
  # get 'items/:id' => 'items#show'
  # get 'items/new' => 'items#new'
  # post 'items' => 'items#create'
  # get 'items/edit' => 'items#edit'
  # put 'items/:id' => 'items#update'
  # delete 'items/:id' => 'items#destroy'
end
