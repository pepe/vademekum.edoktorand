#encoding: utf-8
require 'spec_helper'

feature "Front page", type: :request do
  background { Document.create(name: 'Basic',
                              description: 'Some basic document',
                              body: '# Some basic document',
                              type: 'expectations') }

  scenario "shows document name, description and type" do
    visit '/'
    page.should have_content 'Basic'
    page.should have_content 'Some basic document'
    find('div.type').text.should == 'Expectations'
  end

  after :all do
    Document.delete_all
  end
end
