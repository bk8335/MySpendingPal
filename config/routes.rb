Rails.application.routes.draw do
 
  get 'daily_expenses/new'

  get 'daily_expenses/show'

  get 'daily_expenses/edit'

  get 'daily_expenses/destroy'

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
get '/getting-started', to: 'pages#getting_started'

#users  
resources :users do
	  resources :incomes
	  resources :expenses
	  resources :savings
    resources :daily_expenses
    get 'monthly_entries'
    get 'analysis'
end
get '/signup',		to: 'users#new'
post '/signup',		to: 'users#create'
get 'users/monthly_summary'
  
#entries
resources :incomes
resources :expenses
resources :daily_expenses
resources :savings
get '/entries/fixed_items'

#sessions
get    '/login',   to: 'sessions#new'
post   '/login',   to: 'sessions#create'
delete '/logout',  to: 'sessions#destroy'

#account activation
resources :account_activations, only: [:edit]

end
