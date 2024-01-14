source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0.8"

gem "sprockets-rails"

gem "puma", "~> 5.0"

gem "importmap-rails"

gem "turbo-rails"

gem "stimulus-rails"

gem "jbuilder"

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", require: false

gem 'time_difference'

gem 'sidekiq'

gem 'simplecov', require: false, group: :test

gem 'jquery-rails'

gem 'will_paginate', '~> 4.0'

gem 'gon'

gem 'notion-sdk-ruby'

gem 'activerecord-import'

gem 'brakeman'

gem 'rails-erd'

gem 'rack-cors', require: 'rack/cors'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 6.0.0'
  gem 'dotenv-rails'
  gem "sqlite3", "~> 1.4"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem 'shoulda-matchers', '~> 5.0'
end

gem "devise", "~> 4.9"
