module WhoToBlame
  class Engine < Rails::Engine
    require 'gon'
    require 'react-rails'
    require 'rails-assets-chartjs'
    require 'rails-assets-react'
    require 'rails-assets-reqwest'
    require 'rails-assets-routie'
    require 'rails-assets-underscore'

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
