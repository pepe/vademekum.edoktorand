#encoding: utf-8
require 'spec_helper'

feature "Filling questionnaires", type: :request do
  background do
    FactoryGirl.create(:questionnaire)
    FactoryGirl.create(:account)
    spec_auth("koska")
    visit '/'
    click_on 'Fill'
    check "yes"
    choose "simply red"
    fill_in "how-big", with: "45"
    click_on "Create PDF"
  end

  scenario "downloading sheet pdf" do
    expect(page.response_headers["Content-Type"]).to match(Regexp.new("pdf"))
  end

  scenario "downloading sheet next time" do
    visit "/"
    expect(page).to have_content('Filled at:')
    page.find("p.metadata small a").click
    expect(page.response_headers["Content-Type"]).to match(Regexp.new("pdf"))
  end
end
