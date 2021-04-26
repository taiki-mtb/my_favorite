Rails.application.routes.draw do
  root 'top_pages#top'
  get    :login,     to: 'sessions#new'
  post   :login,     to: 'sessions#create'
  delete :logout,    to: 'sessions#destroy'
  resources :musics do
    collection do
      get 'search'
    end    
  end
  resources :dances do
    collection do
      get 'search'
    end
  end
  resources :stages do
    collection do
      get 'search'
    end      
  end
  resources :artists
  resources :tags do
    get 'musics',    to: 'musics#tag'
    get 'dances',    to: 'dances#tag'
    get 'stages',    to: 'stages#tag'
  end
  resources :lists do
    get 'musics',    to: 'musics#list'
    get 'dances',    to: 'dances#list'
    get 'stages',    to: 'stages#list'
  end
end
