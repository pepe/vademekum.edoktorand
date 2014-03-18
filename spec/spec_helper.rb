RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require 'capybara/rspec'

FactoryGirl.find_definitions

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  conf.after do
    Document.delete_all
    Account.delete_all
    FileUtils.rm_rf("spec/fixtures/sheets")
  end

  conf.mock_with :rspec do |c|
    c.yield_receiver_to_any_instance_implementation_blocks = true
  end
end

def app
  Padrino.application
end

def spec_auth(login)
  visit "/authenticate/#{login}/#{Digest::SHA1.hexdigest(login)}"
end

Capybara.app = Padrino.application
