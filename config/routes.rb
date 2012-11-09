GogetixWeb::Application.routes.draw do
  resources :events

  authenticated :user do
    root :to => 'events#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end