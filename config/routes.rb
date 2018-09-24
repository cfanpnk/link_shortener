Rails.application.routes.draw do
  root 'links#new'
  resources :links, only: [:create, :show, :index], param: :slug
  get '/s/:hash_key' => 'links#go'

  namespace :admin do
    resources :links, only: [:show, :update]
  end
end
