source 'https://rubygems.org'
ruby '2.4.4'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2'
# Page caching system
gem "actionpack-page_caching"
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use jsonb accessor with postgresql
gem 'jsonb_accessor', '~> 1.0'
# Use Devise
gem 'devise', '~> 4.4', '>= 4.4.3'
# Use CanCanCan
gem 'cancancan'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Boostrap sass
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# use datepicker-bootstrap
# gem 'bootstrap-datepicker-rails', :require => 'bootstrap-datepicker-rails',
#                               :git => 'git://github.com/Nerian/bootstrap-datepicker-rails.git'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.11'
# Use rails admin
gem 'rails_admin', '~> 1.3'
# Use Simple Form
gem 'simple_form', '~> 4.0', '>= 4.0.1'
# Use Cocoon gem for nested forms
gem 'cocoon'
# Use Selectize for select field
# gem "selectize-rails"
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# Use Enum_help for select option i18n
gem 'enum_help'
# Use shrine for file uploads
gem 'shrine'
# jQuery UI gem
gem 'jquery-ui-rails'
# Use Client side validation for ajax posts
gem 'client_side_validations'
gem 'client_side_validations-simple_form'
# Use i18n task to manage translations
# Using Bootstrap datepicker gem
gem 'bootstrap-datepicker-rails', :require => 'bootstrap-datepicker-rails',
                              :git => 'git://github.com/Nerian/bootstrap-datepicker-rails.git'
# Use Prawn for PDF documents
gem 'prawn'
gem 'prawn-table'
gem 'prawn-rtl-support'
# Using Reponders
gem 'responders', '~> 2.4'
# Money gem for currency formatting
gem 'money', '~> 6.10', '>= 6.10.1'
# Humanize gem from number to letters
gem 'humanize'
# Localize Javascript
gem "i18n-js"
# Valid mail 2
gem "valid_email2"
# Filterrific for listing and filtering results with will_paginate and chardinjs
gem 'filterrific'
gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem "chardinjs-rails"
# By_star gem to handle dates easily
gem 'by_star', git: "git://github.com/radar/by_star"
#gems to export data to xlsx files
gem 'rubyzip', '>= 1.2.1'
gem 'axlsx', git: 'https://github.com/randym/axlsx.git', ref: 'c8ac844'
gem 'axlsx_rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard'
  gem 'guard-rails', require: false
  gem 'guard-sass', :require => false
  gem "zero_downtime_migrations"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
