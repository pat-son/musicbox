Rails.application.routes.draw do
  get 'index' => 'home#index'
  get 'help'  => 'home#help'
  get 'contact' => 'home#contact'

  root 'home#index'
end
