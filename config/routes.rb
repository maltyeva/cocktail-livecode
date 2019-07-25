Rails.application.routes.draw do

  root to: 'cocktails#index'

  resources :cocktails, only: [:new, :create, :index, :show] do
    resources :doses, shallow: true, except: [:index, :edit, :update, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
