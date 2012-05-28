PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require 'capybara/rspec'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  Padrino.application
end

Capybara.app = Padrino.application
