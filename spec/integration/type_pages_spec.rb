#encoding: utf-8
require 'spec_helper'

feature "Type pages", type: :request do
  background do
    Document.create(name: 'Expectations',
                    desc: 'Some expectations document',
                    body: '# Some expectations document',
                    type: 'expectations')
    Document.create(name: 'Records',
                    desc: 'Some records document',
                    body: '# Some records document',
                    type: 'records')
    account = Account.create(login: 'koska',
                             name: 'Joska Koska')
  end

  scenario "showing records documents" do
    visit '/'
    click_on 'Records'
    page.should have_content('Some records document')
  end

  scenario "showing expectations documents" do
    visit '/'
    click_on 'Expectations'
    page.should have_content('Some expectations document')
  end

  scenario "not crashing when no documents of the type" do
    visit '/'
    click_on 'Analysis'
    page.should_not have_content('Error')
  end
end

