Rails.application.routes.draw do
 
  get 'sessions/new'

# static pages
root 'pages#home'
get 'pages/home'
get '/about', to: 'pages#about'
get '/contact', to: 'pages#contact'

#users  
resources :users
get '/signup',		to: 'users#new'
post '/signup',		to: 'users#create'
  
#entries
resources :incomes
resources :expenses
resources :savings
get '/entries/fixed_items'

#sessions
get    '/login',   to: 'sessions#new'
post   '/login',   to: 'sessions#create'
delete '/logout',  to: 'sessions#destroy'

end
