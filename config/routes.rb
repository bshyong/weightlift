Rails3MongoidDevise::Application.routes.draw do
  resources :quotes


  resources :reps


  resources :lifts


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  match 'test', :to => "home#temp_home"
  devise_for :users
  resources :users
end