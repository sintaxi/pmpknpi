require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "Sessions Controller", "index action" do
  before(:each) do
    @controller = Sessions.build(fake_request)
    @controller.dispatch('index')
  end
end