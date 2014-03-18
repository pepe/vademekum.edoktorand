#encoding: utf-8
require 'spec_helper'

feature "Login", type: :request do
  background do
    FactoryGirl.create(:account)
  end

  scenario "showing not logged page" do
    visit "/"
    expect(page).to have_content('You are not logged in. Please do so from eDoktorand.')
  end

  scenario "loggind in" do
    visit "/authenticate/koska/4a6f77a6de3d7b16e0e566fe9a7760fa4a657004"
    expect(page).to have_content 'Your wall'
  end
end

