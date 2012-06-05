#encoding: utf-8
require 'spec_helper'

feature "View document" do
  background do
    Document.create(name: 'Basic',
                    desc: 'Some basic document',
                    body: '# Some basic document',
                    type: 'expectations')
    Account.create(login: 'koska', name: 'Joska Koska')
  end

  scenario "getting to document detail" do
    visit '/'
    click_on 'View'
    find('h1').text.should == 'Basic'
    page.should have_content 'Some basic document'
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
