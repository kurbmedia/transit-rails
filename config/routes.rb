Transit::Engine.routes.draw do
  resources :pages, :menus
  resources :menu_items, only: [:create, :new]
end
