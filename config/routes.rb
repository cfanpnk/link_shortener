Rails.application.routes.draw do
  root 'links#index'
  resources :links, only: [:create, :show, :index]
  get '/:hash_key' => 'links#go'

  namespace :admin do
    resources :links, only: [:show]
  end
end
