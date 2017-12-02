Rails.application.routes.draw do
 
# static pages
root 'pages#home'
get 'pages/home'
get '/about', to: 'pages#about'
get '/contact', to: 'pages#contact'

#users  
resources :users
get 'users/new', as: 'signup'
get '/signup',		to: 'users#new'
  

end
