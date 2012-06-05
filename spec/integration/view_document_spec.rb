#encoding: utf-8
require 'spec_helper'

feature "View document" do
  background { Document.create(name: 'Basic',
                              description: 'Some basic document',
                              body: '# Some basic document',
                              types: ['wall', 'expectations']) }

  scenario "getting to document detail" do
    visit '/'
    click_link 'View'
    find('h1').text.should == 'Basic'
  end

  scenario "getting back to previous page" do
    visit '/'
    click_on 'View'
    click_on 'Back to your wall'
    page.should have_content('Your wall')
  end

  after :all do
    Document.delete_all
  end
end
