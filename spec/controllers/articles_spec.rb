require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Articles do
  
  describe "handling GET /articles" do
    before(:each) do
      @controller = dispatch_to(Articles, :index)
    end
  
    it "should be successful" do
      @controller.should respond_successfully
    end
  end
  
end