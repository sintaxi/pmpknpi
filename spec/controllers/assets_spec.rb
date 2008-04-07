require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Assets, "index action" do
  before(:each) do
    dispatch_to(Assets, :index)
  end
end