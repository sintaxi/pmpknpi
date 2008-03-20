# all your other controllers should inherit from this one to share code.
class Application < Merb::Controller
  include AuthenticatedSystem
  include GlobalMixin
  
  before :articles
  
  private
  
  def articles
    Article.with_published do
      @articles = Article.find :all, :order => 'published_at DESC'
    end
    @drafts = Article.find(:all, :conditions => "published_at IS NULL", :order => 'created_at DESC') if logged_in?
  end
  
end