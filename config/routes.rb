Rails.application.routes.draw do

  resources :posts
  get 'tags/:tag', to: 'posts#index', as: :tag

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :documents, only: [:create, :destroy]
    resources :bookmarks, only: [:create, :destroy]
  end

  resources :posts do
    member do
      put "like" => "posts#upvote"
      put "unlike" => "posts#downvote"
    end
  end

resources :posts, only: [] do
  resources :documents do
    member do
      get "download" => "documents#download"
    end
  end
end

  resources :posts, only: [] do
    resources :comments do
      member do
        put "like" => "comments#upvote"
        put "unlike" => "comments#downvote"
      end
    end
  end

  devise_for :users, :controllers => { :registrations => :registrations }
    resources :users, :only => [:index, :show, :destroy]

  post 'preview', to: 'previews#show', as: :preview

  get 'about' => 'welcome#about'

  root to: 'welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
