# all your other controllers should inherit from this one to share code.
class Application < Merb::Controller
  require 'active_record_extension'
  require 'global_mixin'; include GlobalMixin
  
  before :articles
  
  private
  
  def articles
    @articles = Article.find(:all, :order => 'published_on DESC, created_at DESC')
  end
  
end  