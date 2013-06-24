source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'
gem 'high_voltage'
gem 'devise'
gem 'nokogiri'
gem 'aws-sdk'
gem 'paperclip'
gem 'cancan'
gem 'html-pipeline'
gem 'gemoji'
gem 'redis'
gem 'exception_notification'

group :production do
  gem 'thin'
end

gem "simple_calendar", "~> 0.1.5"

group :development do
  gem 'sqlite3'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bourbon'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem 'detect_timezone_rails'
end

gem 'rspec-rails', :group => [:development, :test]

gem 'jquery-rails'

group :test do
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'capybara'
  gem 'database_cleaner'
  gem 'timecop'
  gem 'webmock'
  gem 'vcr'
end
