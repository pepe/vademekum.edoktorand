#encoding: utf-8
require 'spec_helper'

feature "Front page", type: :request do
  background do
    FactoryGirl.create(:document)
    FactoryGirl.create(:account)
    spec_auth("koska")
  end

  scenario "showing user wall with name" do
    visit '/'
    page.should have_content 'Your wall'
    page.should have_content 'Joska Koska'
  end

  scenario "showing document name, description and type" do
    visit '/'
    page.should have_content 'Basic'
    page.should have_content 'Some basic document'
    find('div.type').text.should == 'Records'
  end
end
