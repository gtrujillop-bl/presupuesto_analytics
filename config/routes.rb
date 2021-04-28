Rails.application.routes.draw do
  resources :semilleros
  resources :rubros
  resources :proyectos
  resources :presupuestos
  resources :presupuesto_inicial_proyectos
  resources :investigadors
  resources :grupos
  resources :facultads
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
