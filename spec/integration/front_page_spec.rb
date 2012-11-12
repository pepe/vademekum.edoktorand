#encoding: utf-8
require 'spec_helper'

feature "Front page", type: :request do
  background do
    Document.create(name: 'Basic',
                    desc: 'Some basic document',
                    body: '# Some basic document',
                    type: 'expectations')
    account = Account.create(login: 'koska',
                             name: 'Joska Koska')
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
    find('div.type').text.should == 'Expectations'
  end
end
