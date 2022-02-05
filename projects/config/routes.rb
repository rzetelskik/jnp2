Rails.application.routes.draw do
  resources :projects, only: [:index, :create, :show, :destroy, :update] do
    member do
      put :assign
      put :unassign
    end

    resources :statuses, only: [:create, :index, :destroy, :update], controller: :statuses

    resources :tasks, only: [:create, :index, :destroy, :update, :show] do
      collection do
        get :assigned
      end
      member do
        put :assign
      end
    end
  end
end
