Rails.application.routes.draw do
  resources :links
  root 'links#index'
  get '/:hash_key' => 'links#go'
end
