Rails.application.routes.draw do
  get 'sessions/new'

  root 'home#index'

  get 'index' => 'home#index'
  get 'help'  => 'home#help'

  get 'contact' => 'home#contact'

  get 'signup' => 'users#new'

  get    'login' => 'sessions#new'
  post   'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users
end
