Rails.application.routes.draw do
  namespace :admin do
    resources :members

    root to: 'members#index'
  end

  root "pages#result"
end

