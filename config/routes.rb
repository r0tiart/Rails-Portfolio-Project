Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root "application#welcome"
	resources :users, only: [:new, :create, :index, :show, :update, :edit] do
		resources :friends, only: [:index] #all friends
	end

	get 'users/:id/pending_friends', to: 'friends#pending_friends', as: 'pending'

	get "signin" => "sessions#new"
	resources :sessions, only: [:create, :destroy]

	resources :books

	resources :user_books, only: [:index, :update, :edit]
	post "addbook/:id" => "user_books#create", as: "addbook"

end
