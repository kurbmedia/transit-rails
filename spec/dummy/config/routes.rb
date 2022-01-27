Rails.application.routes.draw do
  mount Transit::Engine => "/transit"
end
