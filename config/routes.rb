Rails.application.routes.draw do
  resources :products

  resource :cart, only: [:show, :destroy] do
    collection do
      post :add, path: "/add/:id"
      get :checkout
    end
  end

  resources :orders, only: [:index, :show, :create] do
    member do
      put :cancel
    end
  end
end
