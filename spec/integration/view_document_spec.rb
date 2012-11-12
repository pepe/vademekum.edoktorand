#encoding: utf-8
require 'spec_helper'

feature "View document" do
  background do
    FactoryGirl.create(:document)
    FactoryGirl.create(:account)
    spec_auth("koska")
  end

  scenario "getting to document detail" do
    visit '/'
    click_on 'View'
    find('div.hero-unit').text.should == 'Some basic document'
  end

  scenario "getting back to previous page" do
    visit '/'
    click_on 'View'
    click_on 'Your wall'
    page.should have_content('Your wall')
  end
end
