source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0.7", ">= 7.0.7.2"
gem 'propshaft'
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'devise'
gem "view_component"
gem 'tailwindcss-rails'
gem 'simple_form'
gem 'zxcvbn'
gem 'zxcvbn-ruby', require: 'zxcvbn'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'faker'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'parallel_tests', '4.2.2'
  gem 'rails-controller-testing'
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'ruby_audit'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :development do
  gem "web-console"
  gem 'guard'
  gem 'guard-livereload', require: false
  gem 'letter_opener'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
