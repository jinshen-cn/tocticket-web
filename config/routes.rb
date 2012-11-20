GogetixWeb::Application.routes.draw do
  
  resources :events do
    resources :tickets
  end
  match 'my_tickets' => 'tickets#my_tickets', :as => :my_tickets

  authenticated :user do
    root :to => 'events#index'
  end
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",  :registrations => "users/registrations"  }
  resources :users
end