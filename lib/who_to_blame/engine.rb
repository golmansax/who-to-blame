module WhoToBlame
  class Engine < Rails::Engine
    require 'react-rails'
    require 'rails-assets-react'

    isolate_namespace WhoToBlame

    config.generators do |generator|
      generator.test_framework :rspec
      generator.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
