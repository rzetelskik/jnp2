Rails.application.routes.draw do
  scope :accounts do
    post 'authenticate', to: 'users#authenticate'
    post 'register', to: 'users#register'
    scope '/:username' do
      get :show, to: 'users#show'
    end
  end
  get 'authorize', to: 'users#authorize'
end
