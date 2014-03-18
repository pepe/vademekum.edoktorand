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
    expect(page).to have_content('Some basic document')
  end

  scenario "showing expectations documents" do
    visit '/'
    click_on 'Expectations'
    expect(page).to have_content('Some expectations document')
  end

  scenario "not crashing when no documents of the type" do
    visit '/'
    click_on 'Analysis'
    expect(page).not_to have_content('Error')
  end
end

