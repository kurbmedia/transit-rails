Transit::Engine.routes.draw do
  resources :pages do
    post 'deploy', on: :member
  end
  
  resources :settings, except: [:destroy]
  resources :menus
  resources :medias
  resources :menu_items, only: [:create, :new]
    
end

Rails.application.routes.draw do
  get "/transit/config" => 'transit/transit#settings', as: :transit_config
end