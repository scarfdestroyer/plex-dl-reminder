Rails.application.routes.draw do
  
  resources :users do
  	post :link_plex
  end

end
