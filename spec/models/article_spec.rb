require File.join( File.dirname(__FILE__), "..", "spec_helper" )

module ArticleSpecHelper
  def valid_article_attributes
    {
      :title        =>  "Top ten movies of 2007",
      :body         =>  body_markdown,
      :filter       =>  "Markdown",
      :published_at =>  "2008-02-18 18:30:00"
    }
  end
  
  def body_markdown
    "Lorem *ipsum* dolor sit amet, **consectetur** adipisicing elit, 
    sed do eiusmod tempor incididunt ut labore et dolore magna 
    aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
    ullamco laboris nisi ut aliquip ex ea commodo consequat. 
    Duis aute irure dolor in reprehenderit in voluptate velit 
    esse cillum dolore eu fugiat nulla pariatur. Excepteur sint 
    occaecat cupidatat non proident, sunt in culpa qui officia 
    deserunt mollit anim id est laborum. [google](http://google.com)"
  end
  
  def body_textile
    'Lorem _ipsum_ dolor sit amet, *consectetur* adipisicing elit, 
    sed do eiusmod tempor incididunt ut labore et dolore magna 
    aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
    ullamco laboris nisi ut aliquip ex ea commodo consequat. 
    Duis aute irure dolor in reprehenderit in voluptate velit 
    esse cillum dolore eu fugiat nulla pariatur. Excepteur sint 
    occaecat cupidatat non proident, sunt in culpa qui officia 
    deserunt mollit anim id est laborum. "google":http://google.com'
  end
  
  def body_plain_html
    '<p>Lorem <em>ipsum</em> dolor sit amet, <strong>consectetur</strong> adipisicing elit, 
    sed do eiusmod tempor incididunt ut labore et dolore magna 
    aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
    ullamco laboris nisi ut aliquip ex ea commodo consequat. 
    Duis aute irure dolor in reprehenderit in voluptate velit 
    esse cillum dolore eu fugiat nulla pariatur. Excepteur sint 
    occaecat cupidatat non proident, sunt in culpa qui officia 
    deserunt mollit anim id est laborum. <a href="http://google.com">google</a></p>'
  end
  
  def html
    '<p>Lorem <em>ipsum</em> dolor sit amet, <strong>consectetur</strong> adipisicing elit, 
    sed do eiusmod tempor incididunt ut labore et dolore magna 
    aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
    ullamco laboris nisi ut aliquip ex ea commodo consequat. 
    Duis aute irure dolor in reprehenderit in voluptate velit 
    esse cillum dolore eu fugiat nulla pariatur. Excepteur sint 
    occaecat cupidatat non proident, sunt in culpa qui officia 
    deserunt mollit anim id est laborum. <a href="http://google.com">google</a></p>'
  end
end

describe Article do
  
  include ArticleSpecHelper

  before(:each) do
    @article = Article.new
  end

  it "should be valid" do
    @article.attributes = valid_article_attributes
    @article.should be_valid
  end
  
  it "should have a title" do
    @article.attributes = valid_article_attributes
    @article.title.should == "Top ten movies of 2007"
  end
  
  it "should require a title" do
    @article.attributes = valid_article_attributes.except(:title)
    @article.should_not be_valid
  end
  
  it "should have a body" do
    @article.attributes = valid_article_attributes
    @article.body.should == body_markdown
  end
  
  it "should convert Markdown to html" do
    @article.attributes = valid_article_attributes
    @article.filter_content
    @article.body_html.should == html
  end
  
  it "should convert Textile to html" do
    @article.attributes = valid_article_attributes.with(:body => body_textile, :filter => "Textile")
    @article.filter_content
    @article.body_html.should == html
  end
  
  it "should convert Plain HTML to html" do
    @article.attributes = valid_article_attributes.with(:body => body_plain_html, :filter => "Plain HTML")
    @article.filter_content
    @article.body_html.should == html
  end
  
  it "should create permalink" do
    @article.attributes = valid_article_attributes
    @article.create_permalink
    @article.permalink.should == "top-ten-movies-of-2007"
  end
  
  it "should have published_at unless a draft" do
    @article.attributes = valid_article_attributes
    @article.draft_check
    @article.published_at.to_s.should == "Mon Feb 18 18:30:00 -0800 2008"
  end
  
  it "should convert published_at to nil if a draft" do
    @article.attributes = valid_article_attributes.with(:draft => "1")
    @article.draft_check
    @article.published_at.should be_nil
  end

end