require File.join(File.dirname(__FILE__),'..','..','spec_helper')

describe "/articles/edit" do
  before(:each) do
    @controller,@action = get("/articles/edit")
    @body = @controller.body
  end

  it "should mention Articles" do
    @body.should match(/Articles/)
  end
end