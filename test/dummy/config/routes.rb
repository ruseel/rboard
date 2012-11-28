Rails.application.routes.draw do

  mount Rboard::Engine, at: "/rboard", as: "rboard"
end
