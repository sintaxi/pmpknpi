# all your other controllers should inherit from this one to share code.
class Application < Merb::Controller
  include AuthenticatedSystem
  include GlobalMixin
  
  before :articles
  
  private
  
  def articles
    @articles = Article.find(:all, :order => 'published_at DESC, created_at DESC')
  end
  
end  