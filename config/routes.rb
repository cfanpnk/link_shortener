Rails.application.routes.draw do
  resources :links
  root 'links#index'
  get '/:hash_key' => 'links#go'


  namespace :admin do
    resources :links
  end
end
