#encoding: utf-8
require 'spec_helper'

feature "Administer documents" do
  background do
    FactoryGirl.create(:document)
    FactoryGirl.create(:admin)
    spec_auth("admin")
    visit '/'
  end

  scenario "getting to edit the document" do
    click_on "Expectations"
    click_on 'Edit'
    expect(find('li.active').text).to eq('Editing: Basic document')
    expect(page).to have_css('input#name')
    expect(page).to have_css('input#desc')
    expect(page).to have_css('textarea#body')
    expect(page).to have_css('select#type')
  end

  scenario "editing the document" do
    click_on "Records"
    click_on 'Edit'
    fill_in 'name', with: 'Advanced'
    click_on 'Save'
    expect(page).to have_content 'Advanced'
  end

  scenario "creating document" do
    click_on "Expectations"
    click_on 'New document'
    expect(page).to have_content('Creating new document')
    expect(page).to have_css("select#type[selected='expectations']")
    fill_in 'name', with: 'Advanced'
    click_on 'Save'
    expect(page).to have_content 'Advanced'
  end
end
