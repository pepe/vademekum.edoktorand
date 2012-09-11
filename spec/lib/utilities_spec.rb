require 'utilities'

describe Utilities do
  before do
    extend Utilities
    @request = double('RackRequest')
    @request.stub(:env) { { 'PATH_INFO' => 'active' } }
  end

  it "converts markdown to html" do
    menu_active?(@request, 'nonactive').should == ''
  end

  it "returns menu items" do
    menu_items.keys.should == ['/', '/records', '/expectations', '/analysis', '/plan']
  end

  it "returns columnized array" do
    columnize([1, 2, 3, 4, 5, 6, 7]).to_a.should == [[1, 2, 3], [4, 5, 6], [7]]
  end
end

