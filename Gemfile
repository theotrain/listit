source 'https://rubygems.org'
ruby '2.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.5'
# gem 'unicorn'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
gem 'bootstrap-sass', '~> 2.3.2.0'
gem "rest-client", "~> 1.6.7"
# gem 'sucker_punch', '~> 1.0'
gem 'clockwork', require: false
gem 'delayed_job_active_record'

# gem 'will_pickdate', '~> 1.0.0'
#gem "acts_as_list"
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
# gem 'spring',        group: :development

# Use ActiveModel has_secure_password
#gem 'bcrypt-ruby', '=3.0.0'
gem 'bcrypt-ruby', '3.1.2'
gem 'jquery-mousewheel-rails', '~> 0.0.9'  #for will_pickdate

gem 'mailgun-ruby', '~>1.0.2', require: 'mailgun'
gem 'twilio-ruby', '~> 3.12'


group :doc do
  gem 'sdoc', require: false
end

group :development do
  gem 'quiet_assets'
  gem 'pry'
  gem 'sqlite3'
end

group :production do
  gem 'unicorn'
  gem 'unicorn-worker-killer'
  gem 'pg'
  gem 'rails_12factor'
end
