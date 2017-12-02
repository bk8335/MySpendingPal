Rails.application.routes.draw do
  get 'users/new'

  get 'pages/home'

  get '/about', to: 'pages#about'

  get '/contact', to: 'pages#contact'

  root 'pages#home'
end
