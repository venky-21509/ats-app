Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }


 
  root "jobs#index"

  resources :companies do
    resources :jobs, shallow: true do
      resources :applications, shallow: true do
        resources :notes, only: [:create, :destroy], shallow: true
        resources :reminders, only: [:create, :destroy], shallow: true
        member do
          patch :update_status
        end
      end
    end
  end

 
  get "up" => "rails/health#show", as: :rails_health_check

  
end
