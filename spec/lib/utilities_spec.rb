require 'utilities'
require 'spec_helper'

describe Utilities do
  let(:request) {
    double('RackRequest') }
  let(:document) { FactoryGirl.create(:document) }
  let(:questionnaire) { FactoryGirl.create(:questionnaire) }
  let(:account) { FactoryGirl.create(:account) }
  let(:current_type) { "active" }

  before do
    extend Utilities
  end

  it "returns no class if menu is nonactive" do
    expect(menu_active?('nonactive')).to eq('')
  end

  it "returns active class if menu is active" do
    expect(menu_active?('active')).to eq('active')
  end

  it "returns menu items" do
    expect(menu_items.keys).to eq ['/', '/records', '/expectations', '/analysis', '/plan', '/evaluation']
  end

  it "returns columnized array" do
    expect(columnize([1, 2, 3, 4, 5, 6, 7]).to_a).to eq [[1, 2, 3], [4, 5, 6], [7]]
  end

  it "returns view url parameters for document" do
    expect(action_url(document)).to eq [:document, id: document.id]
  end

  it "returns pass url for questionnaire" do
    expect(action_url(questionnaire)).to eq [:fill, id: questionnaire.id]
  end

  it "returns view action for document" do
    expect(action(document)).to eq :view
  end

  it "returns pass action for document" do
    expect(action(questionnaire)).to eq :fill
  end

  it "returns create date for document" do
    expect(date_action(account, document)).to match /Created at: \d+ [A-Z][a-z]+ \d+:\d+/
  end

  it "returns that it was never filled" do
    account.extend Paths
    expect(date_action(account, questionnaire)).to eq "Never filled out"
  end

  it "returns last filling when sheet exists" do
    account.extend Paths
    account.sheets_path = "spec/fixtures/sheets"
    account.save_sheet(questionnaire.id, "spec/fixtures/sheet.pdf")
    expect(date_action(account, questionnaire)).to match(
      /<a href='\/sheets\/#{account.id}\/#{questionnaire.id}.pdf'>Filled at: \d+ [A-Z][a-z]+ \d+:\d+<\/a>/)
  end

  it "returns primary button class for questionnaire" do
    expect(action_class(questionnaire)).to eq 'btn btn-primary'
  end

  it "returns button class for document" do
    expect(action_class(document)).to eq 'btn'
  end
end

