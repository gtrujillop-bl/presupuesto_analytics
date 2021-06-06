Rails.application.routes.draw do
  root to: "welcome#index"
  resources :semilleros
  resources :rubros
  resources :proyectos
  resources :presupuestos do
    collection do
      post 'import'
      get  'new_import'
    end
  end
  resources :presupuesto_inicial_proyectos do
    collection do
      post 'import'
      get  'new_import'
    end
  end
  resources :investigadores
  resources :grupos
  resources :facultades
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
