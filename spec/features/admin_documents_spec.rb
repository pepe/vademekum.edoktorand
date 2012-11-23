#encoding: utf-8
require 'spec_helper'

feature "Administer documents" do
  background do
    FactoryGirl.create(:document)
    FactoryGirl.create(:admin)
    spec_auth("admin")
  end

  scenario "getting to edit the document" do
    visit '/'
    click_on 'Edit'
    find('li.active').text.should == 'Editing: Basic document'
    page.should have_css('input#name')
    page.should have_css('input#desc')
    page.should have_css('textarea#body')
    page.should have_css('select#type')
  end

  scenario "editing the document" do
    visit '/'
    click_on 'Edit'
    fill_in 'name', with: 'Advanced'
    click_on 'Save'
    page.should have_content 'Advanced'
  end

end
