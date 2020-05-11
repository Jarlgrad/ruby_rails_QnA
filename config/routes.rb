Rails.application.routes.draw do
	root 'home#index'

	get '/mtg' => 'pages#mtg'
	post '/mtg' => 'pages#mtg'

	get '/starwars' => 'pages#swccg'
	post '/starwars' => 'pages#swccg'

	get '/about' => 'home#about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
