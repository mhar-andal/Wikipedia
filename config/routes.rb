Rails.application.routes.draw do

  root 'welcome#index'
  resources :articles do
    resources :section, except: [:show] do
      resources :revisions, only: [:index, :show]
    end
    resources :notes, except: [:show]
    resources :bibliographies, except: [:show]
    resources :revisions, only: [:index, :show]
  end
  resources :users, except: [:index, :edit, :update, :destroy]
  resources :sessions, except: [:index, :edit, :update, :destroy]
  post '/sessions' => "sessions#create"
  delete '/sessions' => "sessions#destroy"
  get '/adminpanel' => "users#admin_panel"
end
