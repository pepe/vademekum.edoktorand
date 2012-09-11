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
    click_on 'View'
    find('div.hero-unit').text.should == 'Some basic questionnaire'
  end

  after do
    Questionnaire.delete_all
    Account.delete_all
  end
end

