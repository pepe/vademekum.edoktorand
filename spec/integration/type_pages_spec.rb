#encoding: utf-8
require 'spec_helper'

feature "Type pages", type: :request do
  background do
    FactoryGirl.create(:document)
    FactoryGirl.create(:expectations_document)
    FactoryGirl.create(:account)
    spec_auth("koska")
  end

  scenario "showing records documents" do
    visit '/'
    click_on 'Records'
    page.should have_content('Some basic document')
  end

  scenario "showing expectations documents" do
    visit '/'
    click_on 'Expectations'
    page.should have_content('Some expectations document')
  end

  scenario "not crashing when no documents of the type" do
    visit '/'
    click_on 'Analysis'
    page.should_not have_content('Error')
  end
end

