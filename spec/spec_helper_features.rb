require 'spec_helper'

require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/session'
require 'capybara/poltergeist'

TourConf::Application.config.cache_classes = true

RSpec.configure do |config|
  config.include SpecSupport::Features::Authentication, type: :feature
  config.extend SpecSupport::Features::ConferenceEvent, type: :feature

  config.use_transactional_fixtures = false

  config.before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end

Capybara.configure do |config|
  config.javascript_driver = :poltergeist
  config.default_wait_time = 5
end

