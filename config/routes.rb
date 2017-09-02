Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root "application#welcome"
	resources :users, only: [:new, :create, :index, :show, :update, :edit] do
		resources :friends, only: [:index, :create, :update] #all friends
		resources :books, only: [:new, :create, :index, :show]
	end

	get 'users/:id/pending_friends', to: 'friends#pending_friends', as: 'pending'

	get "signin" => "sessions#new"
	resources :sessions, only: [:create, :destroy]
	get '/auth/facebook/callback' => 'sessions#create'


	resources :books, only: [:index, :show]

	resources :user_books, only: [:index, :edit]
	patch "user_books/:id" => "user_books#update", as: "editUserBook"
	post "addbook/:id" => "user_books#create", as: "addbook"

end
