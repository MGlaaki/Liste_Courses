Rails.application.routes.draw do
  resources :listes do
    resources :articles
    delete 'destroy_all', to: 'articles#destroy_all'
  end

  resources :users

  root 'listes#root'

  get "/log-in" => "sessions#new"
  post "/log-in" => "sessions#create"
  get "/log-out" => "sessions#destroy", as: :log_out

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
