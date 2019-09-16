Rails.application.routes.draw do

# This is for the graphiql, for testing routes, I guess I dont have to use Postman
	  if Rails.env.development?
  		mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  	end
# There can only be one.
  	post "/graphql", to: "graphql#execute"
# But login... I did it the traditional REST routes way due to needing to hand back jwt.
    post '/login', to: 'authentication#create'
# Also edit user, handing back jwt.
    patch '/userupdate', to: 'users#update_current_user'

  # resources :products
  # resources :items
  # resources :exchange_items
  # resources :exchanges


# Creation of a user is handed with a traditional REST route (users#create) due to needing to hand back jwt
  	resources :users, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
