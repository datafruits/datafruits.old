source 'https://rubygems.org'

gem 'rails', '4.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

ruby "2.0.0"

gem 'pg'
gem 'high_voltage'
gem 'devise', '~> 3.0.0'
gem 'nokogiri'
gem 'aws-sdk'
gem 'paperclip'
gem 'cancan'
gem 'html-pipeline'
gem 'gemoji'
gem 'redis'
gem 'exception_notification', '~> 4.0.0.rc1'
gem 'statsd-ruby'
gem 'httparty'

group :production do
  gem 'thin'
end

gem "simple_calendar", "~> 0.1.5"

group :development do
  gem 'sqlite3'
end

gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'bourbon'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', :platforms => :ruby

gem 'uglifier', '>= 1.0.3'
gem 'detect_timezone_rails', '~> 0.0.5'
gem 'rspec-rails', :group => [:development, :test]
gem 'jquery-rails'
gem 'jquery-cookie-rails', git: 'git://github.com/RyanScottLewis/jquery-cookie-rails'

group :test do
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'capybara'
  gem 'database_cleaner'
  gem 'timecop'
  gem 'webmock'
  gem 'vcr'
  gem 'factory_girl_rails'
  gem 'rake'
end

gem 'rails_12factor'
