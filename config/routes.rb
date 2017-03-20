Rails.application.routes.draw do
  get 'home/index'
  get 'home/contact'

  get 'index' => 'home#index'
  get 'contact' => 'home#contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
end
