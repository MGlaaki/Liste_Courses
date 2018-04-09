Rails.application.routes.draw do
  resources :listes do
    resources :articles
    delete 'destroy_all', to: 'articles#destroy_all'
  end

  root 'listes#root'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
