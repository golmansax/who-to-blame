source 'https://rubygems.org'
source 'https://rails-assets.org'

gemspec

group :development do
  gem 'rubocop'
  gem 'travis-lint'
end

group :test do
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'protected_attributes'
  gem 'rake'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'spork'
end

group :development, :test do
  gem 'teaspoon'
end
