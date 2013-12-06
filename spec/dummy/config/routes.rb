Rails.application.routes.draw do
  mount Transit::Engine => "/transit"
  get "/:slug" => 'pages#show'
end
