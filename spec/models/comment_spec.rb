require File.join( File.dirname(__FILE__), "..", "spec_helper" )

module CommentSpecHelper
  def valid_comment_attributes
    {
      :article_id => "1",
      :author     => "1",
      :name       => 'thurston moore',
      :email      => 'thurston@psychichearts.com',
      :website    => 'http://psychichearts.com',
      :body       => 'fuzzy peach, teenaged computer'
    }
  end
  
  def mods_up
    "1,2,3,4,5"
  end
  
  def mods_down
    "6,7"
  end

end

describe Comment do
  include CommentSpecHelper
  
  before :each do
    @comment = Comment.new
  end

  it "should be valid" do
    @comment.attributes = valid_comment_attributes
    @comment.should be_valid
  end
  
  describe "article" do
    it "should fail without article_id" do
      @comment.attributes = valid_comment_attributes.except(:article_id)
      @comment.should_not be_valid
    end
  end
  
  describe "name" do
    it "should fail without name" do
      @comment.attributes = valid_comment_attributes.except(:name)
      @comment.should_not be_valid
    end
  end
  
  describe "email" do
    it "should fail without email" do
      @comment.attributes = valid_comment_attributes.except(:email)
      @comment.should_not be_valid
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
  
  describe "website" do
    it "should pass without website" do
      @comment.attributes = valid_comment_attributes.except(:website)
      @comment.should be_valid
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

    it "should pass if http://www.sonicyouth.com" do
      @comment.attributes = valid_comment_attributes.with(:website => "http://www.sonicyouth.com")
      @comment.should be_valid
    end

    it "should pass if http://sonicyouth.com" do
      @comment.attributes = valid_comment_attributes.with(:website => "http://sonicyouth.com")
      @comment.should be_valid
    end

    it "should pass if https://sonicyouth.com" do
      @comment.attributes = valid_comment_attributes.with(:website => "https://sonicyouth.com")
      @comment.should be_valid
    end
  end

end

describe "Voting System" do
  include CommentSpecHelper
  
  before :all do
    @comment = Comment.new
    @comment.attributes = valid_comment_attributes.with(:mods_up => mods_up, :mods_down => mods_down)
  end
  
  it "should have author" do
    @comment.author.should == "1"
  end
  
  it "should have author as first mods_up" do
    @comment.mods_up_array.include?(@comment.author).should be_true
  end
  
  it "should not have a mod_up if author mods down" do
    @comment.mod_down @comment.author
    @comment.mods_down_array.include?(@comment.author).should be_true
    @comment.mods_up_array.include?(@comment.author).should_not be_true
  end
end

