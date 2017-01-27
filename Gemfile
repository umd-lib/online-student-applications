source 'https://rubygems.org'

# use HTTPS for github repos (see https://bundler.io/git.html#security)
git_source(:github){ |repo_name| "https://github.com/#{repo_name}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
gem 'pg', group: :production
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'will_paginate', '~> 3.1.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# dotenv - For storing production configuration parameters
gem 'dotenv-rails', '~> 2.1.1'

# Use Capistrano for deployment
gem 'capistrano-rails', group: :development
gem 'figaro'

gem 'umd_lib_style', github: 'umd-lib/umd_lib_style', ref: '0.2.0'
gem 'rack-cas'

gem 'simple_form'
gem 'cocoon'
gem 'country_select'
gem 'bootstrap-toggle-rails'
gem 'will_paginate-bootstrap'


gem 'paperclip', '~> 5.0.0'

gem 'delayed_job_active_record'
gem "delayed_job_web"
gem "daemons"

gem 'faker'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'pry-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'ruby_dep', '~> 1.3.1'
  gem 'guard', require: false
  gem 'guard-minitest', require: false
  gem 'rb-fsevent', require: false
  gem 'terminal-notifier-guard', require: false

  gem 'rubocop'
end

group :test do
  gem 'minitest-rails-capybara'
  gem 'connection_pool'
  gem 'launchy'
  gem 'minitest-reporters'
  # use the head to get the callback functionality
  gem 'capybara-screenshot'
  gem 'rack_session_access'
  gem 'mocha'
  gem 'poltergeist'
  gem 'shoulda-context'
  gem 'shoulda-matchers', '>= 3.0.1'
  gem 'test_after_commit'
  gem 'simplecov', require: false
  gem 'database_cleaner'
end
