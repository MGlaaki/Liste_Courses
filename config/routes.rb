Rails.application.routes.draw do
  resources :articles

  root 'articles#index'

  delete 'destroy_all', to: 'articles#destroy_all'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
