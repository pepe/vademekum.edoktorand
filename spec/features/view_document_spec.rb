#encoding: utf-8
require 'spec_helper'

feature "View document" do
  background do
    FactoryGirl.create(:document)
    FactoryGirl.create(:account)
    spec_auth("koska")
  end

  scenario "getting to document detail" do
    visit '/expectations'
    click_on 'View'
    expect(find('div.hero-unit').text).to eq 'Some basic document'
    expect(find('ul.breadcrumb').text).to have_content 'Expectations'
  end

  scenario "getting back to previous page" do
    visit '/records'
    click_on 'View'
    click_on 'Your wall'
    expect(page).to have_content('Your wall')
  end

  scenario "getting back to documents type" do
    visit '/expectations'
    click_on 'View'
    within('ul.breadcrumb') do
      click_on 'Expectations'
    end
    expect(find('ul.breadcrumb').text).to have_content 'Expectations'
  end
end
