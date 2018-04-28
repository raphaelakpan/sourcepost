Rails.application.routes.draw do
  get 'pages/home', to: 'static_pages#home'
  get 'pages/help', to: 'static_pages#help'
  get 'pages/about', to: 'static_pages#about'

  root 'static_pages#home'
end
