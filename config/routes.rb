require 'sidekiq/web'

Rails.application.routes.draw do
	mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
	mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htmlz
	root to: 'home#index'

	resource :timeline, only: %i(show)

	resources :accounts, only: %i(show) do
		resources :follows, only: %i(create)
		resources :unfollows, only: %i(create)
		member do
			get :followings, :followers
		end
	end

	resource :profile, only: %i(show edit update)

	resources :posts do
		resource :like, only: %i(show create destroy)

		resources :comments, only: %i(index new create)
	end


end
