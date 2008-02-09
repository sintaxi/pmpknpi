require File.join(File.dirname(__FILE__),'..','..','spec_helper')

describe "/comments/edit" do
  before(:each) do
    @controller,@action = get("/comments/edit")
    @body = @controller.body
  end

  it "should mention Comments" do
    @body.should match(/Comments/)
  end
end