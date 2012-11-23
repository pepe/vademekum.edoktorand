require 'utilities'
require 'spec_helper'

describe Utilities do
  let(:request) {
    double('RackRequest') }
  let(:document) { FactoryGirl.create(:document) }
  let(:questionnaire) { FactoryGirl.create(:questionnaire) }
  let(:account) { FactoryGirl.create(:account) }

  before do
    extend Utilities
  end

  it "converts markdown to html" do
    request.stub(:env) { { 'PATH_INFO' => 'active' } }
    menu_active?(request, 'nonactive').should == ''
  end

  it "returns menu items" do
    menu_items.keys.should eq ['/', '/records', '/expectations', '/analysis', '/plan']
  end

  it "returns columnized array" do
    columnize([1, 2, 3, 4, 5, 6, 7]).to_a.should eq [[1, 2, 3], [4, 5, 6], [7]]
  end

  it "returns view url parameters for document" do
    action_url(document).should eq [:document, id: document.id]
  end

  it "returns pass url for questionnaire" do
    action_url(questionnaire).should eq [:fill, id: questionnaire.id]
  end

  it "returns view action for document" do
    action(document).should eq :view
  end

  it "returns pass action for document" do
    action(questionnaire).should eq :fill
  end

  it "returns create date for document" do
    date_action(account, document).should match /Created at: \d+ [A-Z][a-z]+ \d+:\d+/
  end

  it "returns that it was never filled" do
    account.extend Paths
    date_action(account, questionnaire).should eq "Never filled out"
  end

  it "returns last filling when sheet exists" do
    account.extend Paths
    account.sheets_path = "spec/fixtures/sheets"
    account.save_sheet(questionnaire.id, "spec/fixtures/sheet.pdf")
    date_action(account, questionnaire).should match(
      /<a href='\/sheets\/#{account.id}\/#{questionnaire.id}.pdf'>Filled at: \d+ [A-Z][a-z]+ \d+:\d+<\/a>/)
  end

  it "returns primary button class for questionnaire" do
    action_class(questionnaire).should eq 'btn btn-primary'
  end

  it "returns button class for document" do
    action_class(document).should eq 'btn'
  end
end

