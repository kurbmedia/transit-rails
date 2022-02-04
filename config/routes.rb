Transit::Engine.routes.draw do
  resources :pages do
    resources :regions, only: [:show, :create, :update]
  end

  resources :settings, except: [:destroy]
  resources :menus
  resources :medias
  resources :menu_items, only: [:create, :new]
end