module WhoToBlame
  class Engine < Rails::Engine
    require 'react-rails'
    require 'rails-assets-react'
    require 'rails-assets-reqwest'

    isolate_namespace WhoToBlame

    config.generators do |generator|
      generator.test_framework :rspec
      generator.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        app.config.paths['db/migrate'] += config.paths['db/migrate'].expanded
      end
    end
  end
end
