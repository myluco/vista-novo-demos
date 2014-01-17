VistaNovoDemo::Application.routes.draw do

  # resources :patients do
  #   resources :blood_pressures
  # end

  resources :patients
  resources :blood_pressures
  
  root :to => "patients#show"
end
