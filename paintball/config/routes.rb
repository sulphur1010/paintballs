Rails.application.routes.draw do

  # get 'members/dashboard'

  #get "the method name" to: "url path" as: "modify urlpath"
  ##get "url pattern" to: "controller#action" as: "prefix"
  get "dashboard", to: "members#dashboard", as:'member_dashboard'
  get "dashboard/account", to: "members#account", as: 'member_account'
  get 'landings/index'

  
  resources :teams do
    #on: :member is for specific member
    # post "add_member", to: "teams#add_member"
    post 'add_member', on: :member
    delete 'remove_member', on: :member
    put 'transfer_ownership', on: :member
    get 'all_members', on: :member

  end

    # devise_for :members
  # devise_for :members, controllers: {invitations: 'members/invitations', registrations: "members/registrations", sessions: "members/sessions", passwords: "members/passwords"}, skip: [:sessions, :registrations]

   # this is assigning device controllers for member(s)
  # devise_for :members, controllers: {invitations: 'members/invitations', registrations: "members/registrations", sessions: "members/sessions", passwords: "members/passwords"}, skip: [:sessions, :registrations]
  devise_for :members

  resources :games do
    resources :reviews
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'games#index
    root 'landings#index'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  #   devise_scope :member do
  #   get    "login"   => "members/sessions#new",         as: :new_member_session
  #   post   "login"   => "members/sessions#create",      as: :member_session
  #   delete "signout" => "members/sessions#destroy",     as: :destroy_member_session
  #   # put    "update_notification"  => "members#update_notification"

  #   get    "signup"  => "members/registrations#new",    as: :new_member_registration
  #   post   "signup"  => "members/registrations#create", as: :member_registration
  #   put    "signup"  => "members/registrations#update", as: :update_member_registration
  #   get    "account" => "members/registrations#edit",   as: :edit_member_registration
  # end

  
end
