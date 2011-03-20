PatrickBooks::Application.routes.draw do

  resources :books
  
  resource :user_session, :controller => :user_session

  match 'login' => "user_session#new", :as => :login
  match 'logout' => "user_session#destroy", :as => :logout
  match 'loginWithToken' => "user_session#login_with_token", :as => :login_with_token
  
  root :to => 'books#index'
  
end
