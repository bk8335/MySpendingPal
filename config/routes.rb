Rails.application.routes.draw do
 
  get 'savings/new'

  get 'savings/show'

  get 'savings/edit'

  get 'savings/destroy'

  get 'expenses/new'

  get 'expenses/show'

  get 'expenses/edit'

  get 'expenses/destroy'

  get 'sessions/new'

# static pages
root 'pages#home'
get 'pages/home'
get '/about', to: 'pages#about'
get '/contact', to: 'pages#contact'

#users  
# resources :users do
# 	#entries
# 	resources :incomes
# 	resources :expenses
# 	resources :savings
# 	get '/entries/fixed_items'
# end
resources :users do
	  resources :incomes
	  resources :expenses
	  resources :savings
end
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
