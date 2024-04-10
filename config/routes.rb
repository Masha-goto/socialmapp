Rails.application.routes.draw do
	mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htmlz
	root to: 'home#index'

	resources :accounts, only: %i(show) do
		resources :follows, only: %i(create)
		resources :unfollows, only: %i(create)
	end

	resource :profile, only: %i(show edit update)

	resources :posts do
		resource :like, only: %i(show create destroy)

		resources :comments, only: %i(index new create)
	end


end
