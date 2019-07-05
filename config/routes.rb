Rails.application.routes.draw do
  namespace :naturalista do
    resources :estadisticas
  end
  resources :instrumentos
  root 'instrumentos#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
