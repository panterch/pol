Rails::Application.routes.draw do |map|
  resources :pages do
    member do
      post :order
    end

    resources :pages
    resources :comps do
      member do
        put :up
        put :down
      end
      resources :comps
    end
    resources :comp_texts
    resources :comp_raws
    resources :comp_file
    resources :comp_videos
    resources :comp_images
    resources :comp_maps
    resources :comp_galleries
    resources :comp_subnav
  end

  match '/ls-R(.:format)' => 'pol#sitemap'
  match '/exception_test' => 'exception_test#error'
  match '/:permalink', :to => 'pol#show'
end