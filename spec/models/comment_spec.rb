require File.join( File.dirname(__FILE__), "..", "spec_helper" )

module CommentSpecHelper
  def valid_comment_attributes
    {
      :article_id => "1",
      :name       => 'thurston moore',
      :email      => 'thurston@psychichearts.com',
      :website    => 'http://psychichearts.com',
      :body       => 'fuzzy peach, teenaged computer'
    }
  end
end

describe Comment do

  include CommentSpecHelper
  
  before(:each) do
    @comment = Comment.new
  end
  
  it "should be valid" do
    @comment.attributes = valid_comment_attributes
    @comment.should be_valid
  end
  
  it "should fail without article_id" do
    @comment.attributes = valid_comment_attributes.except(:article_id)
    @comment.should_not be_valid
  end
  
  it "should fail without name" do
    @comment.attributes = valid_comment_attributes.except(:name)
    @comment.should_not be_valid
  end
  
  it "should fail without email" do
    @comment.attributes = valid_comment_attributes.except(:email)
    @comment.should_not be_valid
  end
    
  it "should pass without website" do
    @comment.attributes = valid_comment_attributes.except(:website)
    @comment.should be_valid
  end

end

describe Comment, "email-address" do
  
  include CommentSpecHelper
  
  before(:each) do
    @comment = Comment.new
  end
  
  it "should fail if @sonicyouth.com" do
    @comment.attributes = valid_comment_attributes.with(:email => "@sonicyouth.com")
    @comment.should_not be_valid
  end
  
  it "should fail if kim.gordon@sonicyouth" do
    @comment.attributes = valid_comment_attributes.with(:email => "kim.gordon@sonicyouth")
    @comment.should_not be_valid
  end
  
  it "should fail if kim.gordonsonicyouth.com" do
    @comment.attributes = valid_comment_attributes.with(:email => "kim.gordonsonicyouth.com")
    @comment.should_not be_valid
  end
  
  it "should pass if kim@sonicyouth.com" do
    @comment.attributes = valid_comment_attributes.with(:email => "kim@sonicyouth.com")
    @comment.should be_valid
  end
  
  it "should pass if kim+gordon@sonicyouth.com" do
    @comment.attributes = valid_comment_attributes.with(:email => "kim+gordon@sonicyouth.com")
    @comment.should be_valid
  end
  
  it "should pass if kim.gordon@sonicyouth.com" do
    @comment.attributes = valid_comment_attributes.with(:email => "kim.gordon@sonicyouth.com")
    @comment.should be_valid
  end

end

describe Comment, "website" do
  
  include CommentSpecHelper
  
  before(:each) do
    @comment = Comment.new
  end
  
  it "should fail if http:/sonicyouth.com" do
    @comment.attributes = valid_comment_attributes.with(:website => "http:/sonicyouth.com")
    @comment.should_not be_valid
  end
  
  it "should fail if http://sonicyouth" do
    @comment.attributes = valid_comment_attributes.with(:website => "http://sonicyouth")
    @comment.should_not be_valid
  end

  it "should fail if sonicyouth.com" do
    @comment.attributes = valid_comment_attributes.with(:website => "sonicyouth.com")
    @comment.should_not be_valid
  end
  
  it "should pass if http://sonicyouth.com" do
    @comment.attributes = valid_comment_attributes.with(:website => "http://sonicyouth.com")
    @comment.should be_valid
  end

end