Reliefhub::Application.routes.draw do
  root :to => "homes#show", :via => :get

  scope "(:locale)", :locale => /en|fr/ do
    resource :home, :only => [:show]

    resources :comments, :only => [:create]

    resources :projects, :only => [:index, :show] do
      collection do
        get :my_projects
      end
    end

    match 'donations/confirm' => 'donations#confirm'
    match 'donations/abandon' => 'donations#abandon'

    resources :pages, :only => [:show]

    namespace :admin do
      resources :organizations, :except => [:destroy] do
        resources :projects, :except => [:index, :destroy]
      end
      resources :projects, :only => [:index]
      resources :users,    :only => [:index]
    end

    resources :emails, :only => [:create]
    devise_for :users
    
    resources :users do
      collection do
        get :projects
      end
    end

  end

  match '/:locale' => 'homes#show'
end
