require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

APP_RAKEFILE = File.expand_path('../spec/dummy/Rakefile', __FILE__)
puts $LOAD_PATH
load 'rails/tasks/engine.rake'

task default: :spec
