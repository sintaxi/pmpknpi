# Merb::Router is the request routing mapper for the merb framework.
#
# You can route a specific URL to a controller / action pair:
#
#   r.match("/contact").
#     to(:controller => "info", :action => "contact")
#
# You can define placeholder parts of the url with the :symbol notation. These
# placeholders will be available in the params hash of your controllers. For example:
#
#   r.match("/books/:book_id/:action").
#     to(:controller => "books")
#   
# Or, use placeholders in the "to" results for more complicated routing, e.g.:
#
#   r.match("/admin/:module/:controller/:action/:id").
#     to(:controller => ":module/:controller")
#
# You can also use regular expressions, deferred routes, and many other options.
# See merb/specs/merb/router.rb for a fairly complete usage sample.

Merb.logger.info("Compiling routes...")
Merb::Router.prepare do |r|
  
  # sessions
  r.match("/login").to(:controller => "sessions", :action => "new")
  r.match("/admin").to(:controller => "sessions", :action => "new")
  r.match("/sessions/create").to(:controller => "sessions", :action => "create")
  r.match("/logout").to(:controller => "sessions", :action => "destroy")
  
  # moding comments
  r.match("/articles/:article_id/comments/:id/:mod").to(:controller => "comments", :action => "update")
  
  # REGULAR RESOURCES
  r.resources :articles, :collection => {:admin => :get} do |article|
    article.resources :comments, :member => { :mod_up => :get, :mod_down => :get }
    #article.resources :tags
  end
  
  r.resources :assets
  
  # This is the default route for /:controller/:action/:id
  # This is fine for most cases.  If you're heavily using resource-based
  # routes, you may want to comment/remove this line to prevent
  # clients from calling your create or destroy actions with a GET
  #r.default_routes
  
  # Default
  r.match('/').to(:controller => 'articles', :action =>'index')

end
