require 'coveralls'
Coveralls.wear!('rails')

require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  # Configure Rails Environment
  ENV['RAILS_ENV'] ||= 'test'

  require File.expand_path('../dummy/config/environment.rb',  __FILE__)
  require 'rspec/rails'

  Rails.backtrace_cleaner.remove_silencers!

  # Load support files
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

  # Load fixtures from the engine
  if ActiveSupport::TestCase.method_defined?(:fixture_path=)
    fixture_path = File.expand_path('../fixtures', __FILE__)
    ActiveSupport::TestCase.fixture_path = fixture_path
  end

  RSpec.configure do |config|
    config.infer_spec_type_from_file_location!
    config.include FactoryGirl::Syntax::Methods

    config.before(:suite) do
      FactoryGirl.lint
    end
  end
end
