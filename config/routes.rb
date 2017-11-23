require 'api_version_constraint'
Rails.application.routes.draw do
  devise_for :users, only: %i(sessions), controllers: { sessions: 'api/v1/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' },
                  path: '/' do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1, default: true) do
      resources :users, only: %i(show create update destroy)
      resources :sessions, only: %i(create destroy)
      resources :tasks, only: %i(index show)
    end
  end
end
