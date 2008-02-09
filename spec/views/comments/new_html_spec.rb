require File.join(File.dirname(__FILE__),'..','..','spec_helper')

describe "/comments/new" do
  before(:each) do
    @controller,@action = get("/comments/new")
    @body = @controller.body
  end

  it "should mention Comments" do
    @body.should match(/Comments/)
  end
end