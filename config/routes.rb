Rboard::Engine.routes.draw do
  resources :boards do
    resources :topics
  end

  resources :topics
  resources :comments
end
