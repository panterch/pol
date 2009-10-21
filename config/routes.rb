ActionController::Routing::Routes.draw do |map|
  
  map.resources :pages,
                :member => { :order => :post },
                :has_many => :pages do |pages|
    pages.resources :pages # child pages
    pages.resources :comps,
      :member => { :up => :put, :down => :put } do |comps|
      comps.resources :comps
    end
    pages.resources :comp_texts, :controller => 'comps'
    pages.resources :comp_raws, :controller => 'comps'
    pages.resources :comp_file, :controller => 'comps'
    pages.resources :comp_videos, :controller => 'comps'
    pages.resources :comp_images, :controller => 'comps'
    pages.resources :comp_maps, :controller => 'comps'
    pages.resources :comp_galleries, :controller => 'comps'
    pages.resources :comp_subnav, :controller => 'comps'
    pages.resources :comp_calendar, :controller => 'comps'
  end
  
  map.resources :contacts, :only => [:new, :create, :show]
  
  map.connect '/ls-R', :controller => 'pol', :action => 'sitemap'
  map.connect '/exception_test', :controller => 'exception_test',
                                 :action => 'error'

  # you may add theses links to your applications routes.rb
  # map.connect '/', :controller => 'pol', :action => 'index'
  # map.connect '/index', :controller => 'pol', :action => 'index'
  # map.connect '/:id.js', :controller => 'pol',
  #                        :action => 'replace_comp'
  # map.connect '/:permalink', :controller => 'pol', :action => 'show'


end
