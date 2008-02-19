require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "Articles Controller", "index action" do
  
  before(:each) do
    @article = Article.new(:title => "Top ten movies of 2007")
    @article.stub!(:create_permalink).and_return("This is a blog post")
    @controller = Articles.build(fake_request)
    @controller.dispatch('index')
  end
  
  def do_get
    get('index')
  end
  
  it "should be successful" do
    @controller.should respond_to(:index)
  end
  
end