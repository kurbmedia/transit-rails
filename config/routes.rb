Transit::Engine.routes.draw do
  resources :pages, :menus, :medias, :media_folders
  resources :menu_items, only: [:create, :new]
  
  scope "/transit" do
    resources :snippets, only: [:index, :edit, :show]
  end
  
  mount Mercury::Engine => '/'
  get "/mercury/:type/:resource" => 'mercury#resource', as: :mercury_resource
  
end

Rails.application.routes.draw do
  get "/transit/config" => 'transit/transit#settings', as: :transit_config
end