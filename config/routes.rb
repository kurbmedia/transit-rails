Transit::Engine.routes.draw do
  resources :pages, :menus, :medias, :media_folders
  resources :menu_items, only: [:create, :new]
end
