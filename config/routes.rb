PatrickBooks::Application.routes.draw do

  resources :books
  
  resource :user_session, :controller => :user_session

  match 'login' => "user_session#new", :as => :login
  match 'logout' => "user_session#destroy", :as => :logout
  
  root :to => 'books#index'
  
end
