GogetixWeb::Application.routes.draw do
  
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :events do
    resources :tickets
  end
  match 'my_tickets' => 'tickets#my_tickets', :as => :my_tickets

  authenticated :user do
    root :to => 'dashboard#index'
  end
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",  :registrations => "users/registrations"  }
  # Users can delete session even from selector for small screens
  devise_scope :user do
    match '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Manage users
  resources :users
  # Payment Notifications service
  resources :payment_notifications
end