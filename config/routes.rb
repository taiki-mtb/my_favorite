Rails.application.routes.draw do
  root 'top_pages#top'
  get    :search,    to: 'top_pages#search'
  get    :login,     to: 'sessions#new'
  post   :login,     to: 'sessions#create'
  delete :logout,    to: 'sessions#destroy'
  resources :musics
  resources :dances do
    collection do
      get 'search'
    end
  end
  resources :stages
  resources :artists
  resources :tags do
    get 'musics',    to: 'musics#tag'
    get 'dances',    to: 'dances#search'
    get 'stages',    to: 'stages#search'
  end
  resources :lists do
    get 'musics',    to: 'musics#list'
    get 'dances',    to: 'dances#list'
    get 'stages',    to: 'stages#list'
  end
end
