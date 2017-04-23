Rails.application.routes.draw do
  get 'sessions/new'

  root 'home#index'

  get 'index' => 'home#index'
  get 'help'  => 'home#help'

  get 'contact' => 'home#contact'

  get 'signup' => 'users#new'

  get 'creations' => 'creations#index'
  get 'create' => 'creations#new'
  get 'sequence' => 'creations#sequence'

  get    'login' => 'sessions#new'
  post   'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  post 'comments/create' => 'comments#create'
  delete 'comments' => 'comments#destroy'

  resources :users
  resources :creations
  resources :comments
end
