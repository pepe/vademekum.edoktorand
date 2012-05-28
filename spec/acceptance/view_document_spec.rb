#encoding: utf-8
require 'spec_helper'

feature "View document" do
  background { Document.create(name: 'Basic',
                              description: 'Some basic document',
                              body: '# Some basic document') }

  scenario "getting to document detail" do
    visit '/'
    click_link 'View'
    find('h1').text.should == 'Some basic document'
  end

  after :all do
    Document.destroy_all
  end
end
