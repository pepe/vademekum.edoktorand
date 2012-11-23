#encoding: utf-8
require 'spec_helper'

feature "Showing questionnaires", type: :request do
  background do
    FactoryGirl.create(:questionnaire_with_sections)
    FactoryGirl.create(:account)
    spec_auth("koska")
  end

  scenario "showing questionnaire on home page" do
    visit '/'
    page.should have_content('Questionnaire with sections')
  end

  scenario "showing questionnaire form" do
    visit '/'
    click_on 'Fill'
    page.should have_css('#questionnaire')
    page.should have_css('h4', text: "This section is about heads")
    find('div.hero-unit').text.should == 'Some questionnaire with sections'
  end

  scenario "submitting sheet" do
    visit '/'
    click_on 'Fill'
    check "yes"
    choose "simply red"
    fill_in "how-big", with: "45"
    click_on "Create PDF"
  end
end

