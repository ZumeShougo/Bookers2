Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'

  get "/home/about" => "homes#about"

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books

  post "users" => "books#create"

  post "users/:id" => "books#create"

  post "books" => "books#create"
end
