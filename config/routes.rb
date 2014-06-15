TourConf::Application.routes.draw do
  namespace :admin do
    resources :conferences
    resources :events do
      resource :notes, controller: 'event_notes', only: [:edit, :update]
      resources :photos, controller: 'photos', only: [:index, :create, :destroy] do
        patch :reorder, on: :collection
      end
      resources :feedbacks, only: [:index, :destroy], shallow: true
    end
    resources :sessions, only: [:new, :create, :edit, :update, :destroy]
    resources :speakers
    resources :subscribers, only: [:index, :create, :update, :destroy]

    resource :user, only: [:edit, :update]

    root to: redirect('/admin/conferences')
  end

  namespace :sign do
    get    :in,  to: 'sessions#new'
    post   :in,  to: 'sessions#create'
    delete :out, to: 'sessions#destroy'
  end

  if Rails.env.test?
    get '/backdoor/login',  to: 'backdoor#login'
    get '/backdoor/logout', to: 'backdoor#logout'
  end

  resource :subscribers, only: [:new, :create]
  resource :feedbacks, only: [:new, :create]

  resources :speakers, only: [:show]

  get 'archive/:year', to: 'events#show', as: :archive

  root to: 'conferences#show'
end
