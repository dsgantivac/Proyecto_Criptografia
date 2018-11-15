Rails.application.routes.draw do
  get 'admin/index'

  #get 'sessions/new'
  #post 'sessions/new'
  #get 'sessions/create'
  #get 'sessions/destroy'
  resources :sessions
  resources :articles
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'welcome/index'

  root 'welcome#index'

  #get 'admin' => 'admin#index'
#
  #controller :sessions do
  #  get 'login' => :new
  #  post 'login' => :create
  #  delete 'logout' => :destroy
  #end

end
