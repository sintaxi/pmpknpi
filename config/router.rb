Merb.logger.info("Compiling routes...")
Merb::Router.prepare do |r|
  
  # sessions
  r.match("/login").to(:controller => "sessions", :action => "new")
  r.match("/admin").to(:controller => "sessions", :action => "new")
  r.match("/logout").to(:controller => "sessions", :action => "destroy")
  
  # vote on comment
  r.match("/articles/:article_id/comments/:id/:vote").to(:controller => "comments", :action => "update")
  
  # Resources
  r.resources :sessions
  r.resources :assets
  r.resources :comments
  r.resources :articles do |article|
    article.resources :comments
  end
  
  # Default
  r.match('/').to(:controller => 'articles', :action =>'index')

end
