# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.3"

# frontend
gem "bootstrap", "~> 4.2.1"
gem "bootswatch"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "sass-rails", "~> 5.0"
gem "simple_form"
gem "slim"
gem "uglifier", ">= 1.3.0"
gem "webpacker", "~> 4.x"

# backend
gem "active_model_serializers", "~> 0.10.0"
gem "cancancan", "~> 2.0"
gem "decent_exposure", "3.0.0"
gem "devise"
gem "draper"
gem "pg", ">= 0.18", "< 2.0"
gem "pg_search"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.1"

gem "bootsnap", ">= 1.1.0", require: false

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "chromedriver-helper"
  gem "selenium-webdriver"
end

group :test, :development do
  gem "factory_bot_rails"
  gem "ffaker"
  gem "formulaic"
  gem "rspec-rails", "~> 3.7"
end
