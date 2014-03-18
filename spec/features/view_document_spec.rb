#encoding: utf-8
require 'spec_helper'

feature "View document" do
  background do
    FactoryGirl.create(:document)
    FactoryGirl.create(:account)
    spec_auth("koska")
    visit '/records'
    click_on 'View'
  end

  scenario "getting to document detail" do
    expect(find('div.hero-unit').text).to eq 'Some basic document'
    expect(find('ul.breadcrumb').text).to have_content 'Records'
  end

  scenario "getting back to previous page" do
    click_on 'Your wall'
    expect(page).to have_content('Your wall')
  end

  scenario "getting back to documents type" do
    within('ul.breadcrumb') do
      click_on 'Records'
    end
    expect(find('ul.breadcrumb').text).to have_content 'Records'
  end
end
