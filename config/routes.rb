Rails.application.routes.draw do

  root 'welcome#index'
  resources :articles do
    resources :sections, except: [:show] do
      resources :revisions, only: [:index, :show]
    end
    resources :notes, except: [:show]
    resources :bibliographies, except: [:show]
    resources :revisions, only: [:index, :show]
  end
  resources :users, except: [:index, :edit, :update, :destroy]
  resources :sessions, except: [:index, :edit, :update, :destroy]
  resources :categories, only: [:new, :create]
  get '/users/:id/article_manager' => "users#article_manager", as: :article_manager
  # post '/users/:id/article_manager' => "users#post_article_manager"
  put '/articles/:article_id/categories/:category_id' => "articles#update_category"
  post '/sessions' => "sessions#create"
  delete '/sessions' => "sessions#destroy"
  get '/users/:user_id/admin_panel' => "users#admin_panel"
  post '/article/:id/publish' => "articles#update_publish"
  post '/article/:id/deny' => "articles#deny"
  post '/article/:id/request_submision' => "articles#request_submission"
end
