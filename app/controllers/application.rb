# all your other controllers should inherit from this one to share code.
class Application < Merb::Controller
  include AuthenticatedSystem
  include GlobalMixin
  
  before :articles
  
  private
  
  def articles
    if logged_in?
      @articles = Article.find :all, :order => 'published_at DESC'
      @assets = Asset.find :all, :conditions => "parent_id IS NULL", :order => "created_at DESC"
    else
      Article.with_published do
        @articles = Article.find :all, :order => 'published_at DESC'
      end
    end
  end
  
end