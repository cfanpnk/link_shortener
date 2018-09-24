Rails.application.routes.draw do
  root 'links#new'
  resources :links, only: [:create, :show, :index], param: :slug
  get '/:hash_key' => 'links#forward'

  namespace :admin do
    resources :links, only: [:show, :expire], param: :slug do
      member do
        put :expire
      end
    end
  end
end
