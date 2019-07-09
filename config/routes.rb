Rails.application.routes.draw do

  namespace :naturalista do
    resources :estadisticas
  end

  namespace :juridico do
    root 'instrumentos#index'
    resources :instrumentos
  end

end
