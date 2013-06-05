TourConf::Application.routes.draw do
  namespace :admin do
    resources :conferences
    resources :events do
      resource :notes, controller: 'event_notes', only: [:edit, :update]
    end
    resources :sessions, only: [:new, :create, :edit, :update, :destroy]
    resources :speakers
    resources :subscribers, only: [:index, :create, :update, :destroy]

    resource :user, only: [:edit, :update]

    root to: 'conferences#index'
  end

  namespace :sign do
    get    :in,  to: 'sessions#new'
    post   :in,  to: 'sessions#create'
    delete :out, to: 'sessions#destroy'
  end

  get 'archive/:year', to: 'events#show', as: :archive

  root to: 'events#index'
end
