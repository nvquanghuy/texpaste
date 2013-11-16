Mathshare::Application.routes.draw do
  root :to => 'notes#new'

  resources :notes

  get "/n/:slug/raw" => 'notes#show', :as => :show_raw_note, :raw => true
  match "/n/:slug" => 'notes#show', :as => :show

  match "/n/:slug/edit" => 'notes#edit', :as => :edit_note
  match "/manage" => 'notes#manage', :as => :manage

  post "/notes/update_views" => 'notes#update_views', as: :update_views

  get "logout" => "sessions#destroy", :as => "log_out"
  get "login" => "sessions#new", :as => "log_in"
  get "signup" => "users#new", :as => "sign_up"
  get 'symbols.json' => 'notes#symbols'

  get "sessions/new"
  get "users/new"
  get 'about' => 'pages#about'

  resources :users
  resources :sessions

end
