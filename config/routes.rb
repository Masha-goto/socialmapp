Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htmlz
	root to: 'home#index'

	resource :profile, only: %i(show edit update)

	resources :posts do
		resource :like, only: %i(show create destroy)

		resources :comments, only: %i(show new create)
	end


end
