Rails.application.routes.draw do
  root 'home#index'

  get 'index' => 'home#index'
  get 'help'  => 'home#help'
  get 'contact' => 'home#contact'
  get 'signup' => 'users#new'
  resources :users
end
