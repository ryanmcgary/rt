Rails.application.routes.draw do
  resources :links
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "links#new"

  get '/l/:hash_id', to: 'links#redirect', as: "redirection"
  get '/admin/:uuid', to: 'links#edit', as: "link_admin"
end
