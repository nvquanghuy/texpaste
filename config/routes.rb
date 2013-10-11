Mathshare::Application.routes.draw do

  resources :notes
  root :to => 'notes#new'
  match "/n/:slug" => 'notes#show', :as => :show
  match "/n/:slug/edit" => 'notes#edit', :as => :edit_note
  match "/manual"  => 'notes#manual', :as => :manual
  match "/manage" => 'notes#manage', :as => :manage

  get "logout" => "sessions#destroy", :as => "log_out"
  get "login" => "sessions#new", :as => "log_in"
  get "signup" => "users#new", :as => "sign_up"

  get "sessions/new"
  get "users/new"
  get 'about' => 'pages#about'

  resources :users
  resources :sessions

end
