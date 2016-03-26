ENV['RACK_ENV'] = 'test'

require 'capybara/rspec'
require 'tilt/erb'

require File.join(File.dirname(__FILE__), '..', '/app/app.rb')

require 'capybara'
require 'rspec'
require 'database_cleaner'
require_relative 'helpers/session'

Capybara.app = BookmarkManager

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include Capybara::DSL
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include SessionHelpers
end
