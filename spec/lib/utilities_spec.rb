require 'utilities'
require 'spec_helper'

describe Utilities do
  let(:request) {
    double('RackRequest') }
  let(:document) { FactoryGirl.create(:document) }
  let(:questionnaire) { FactoryGirl.create(:questionnaire) }

  before do
    extend Utilities
  end

  it "converts markdown to html" do
    request.stub(:env) { { 'PATH_INFO' => 'active' } }
    menu_active?(request, 'nonactive').should == ''
  end

  it "returns menu items" do
    menu_items.keys.should == ['/', '/records', '/expectations', '/analysis', '/plan']
  end

  it "returns columnized array" do
    columnize([1, 2, 3, 4, 5, 6, 7]).to_a.should == [[1, 2, 3], [4, 5, 6], [7]]
  end

  it "returns view url parameters for document" do
    action_url(document).should == [:document, id: document.id]
  end

  it "returns pass url for questionnaire" do
    action_url(questionnaire).should == [:fill, id: questionnaire.id]
  end

  it "returns view action for document" do
    action(document).should == :view
  end

  it "returns pass action for document" do
    action(questionnaire).should == :fill
  end
end

