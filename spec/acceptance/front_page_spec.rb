#encoding: utf-8
require 'spec_helper'

feature "Front page", type: :request do
  background { Document.create(name: 'Basic',
                              description: 'Some basic document',
                              body: '# Some basic document') }

  scenario "shows document name and description" do
    visit '/'
    page.should have_content 'Basic'
    page.should have_content 'Some basic document'
  end

  after :all do
    Document.destroy_all
  end
end
