require File.join(File.dirname(__FILE__),'..','..','spec_helper')

describe "/sessions" do
  before(:each) do
    @controller,@action = get("/sessions")
    @body = @controller.body
  end

  it "should mention Sessions" do
    @body.should match(/Sessions/)
  end
end