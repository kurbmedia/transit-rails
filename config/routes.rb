Transit::Engine.routes.draw do
  resources :settings, except: [:destroy]
  resources :resources
end

Rails.application.routes.draw do
  get "/transit/config" => 'transit/transit#settings', as: :transit_config
end