Rails3MongoidDevise::Application.routes.draw do
  resources :quotes

  resources :lifts do
      resources :reps
  end


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  match 'test', :to => "home#temp_home"

  match 'track', :to => 'home#track'

  devise_for :users
  resources :users
end