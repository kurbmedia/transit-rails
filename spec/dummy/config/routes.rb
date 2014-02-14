Rails.application.routes.draw do
  mount Transit::Engine => "/transit"
  mount Konacha::Engine, at: '/konacha'
  
  get "/:slug" => 'pages#show', slug: /(?!admin|transit).*/
end
