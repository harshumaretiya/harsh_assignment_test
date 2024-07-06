Rails.application.routes.draw do
  resources :users do
    collection do
      get 'filter'
    end
  end
end
