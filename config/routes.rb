DatafruitsRails::Application.routes.draw do
  resources :shows
  devise_for :users, :controllers => { :registrations => "registrations", :sessions => "sessions" }
  scope "/admin" do
    resources :users
  end
  resources :users
  resources :posts
  resources :podcasts

  get '/podcasts', to: 'application#podcast'
  get '/podcast', to: 'application#podcast'
  get '/metadata', to: 'application#metadata'
  get '/playlist', to: 'application#playlist'
  get '/chatroom', to: 'application#chatroom'
  get '/schedule', to: 'shows#index'
  get '/timetable', to: 'shows#index'
  get '/listen' => 'high_voltage/pages#show', :id => 'listen'
  get '/about' => 'high_voltage/pages#show', :id => 'about'
  get '/contact' => 'high_voltage/pages#show', :id => 'about'
  get '/help' => 'high_voltage/pages#show', :id => 'help'
  
  as :user do
    get "/login" => "sessions#new"
    post "/login" => "sessions#create"
    delete "/logout" => "sessions#destroy"
  end


  root :to => 'posts#index'
end
