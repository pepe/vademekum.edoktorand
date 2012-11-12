#encoding: utf-8
require 'spec_helper'

feature "Showing questionnaires", type: :request do
  background do
    FactoryGirl.create(:questionnaire)
    FactoryGirl.create(:account)
  end

  scenario "showing questionnaire on home page" do
    visit '/'
    page.should have_content('Basic questionnaire')
  end

  scenario "showing questionnaire form" do
    visit '/'
    click_on 'Fill'
    page.should have_css('#questionnaire')
    find('div.hero-unit').text.should == 'Some basic questionnaire'
  end

  scenario "filling sheet" do
    visit '/'
    click_on 'Fill'
    check "yes"
    choose "simply red"
    fill_in "how-big", with: "45"
    click_on "Submit"
    page.should have_content('Submited successfully')
  end
end

