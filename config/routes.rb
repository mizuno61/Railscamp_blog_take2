Rails.application.routes.draw do
  # get 'articles/new'
  # get 'articles/edit'
  devise_for :users
  root 'pages#index'
  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
  resources :articles
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
