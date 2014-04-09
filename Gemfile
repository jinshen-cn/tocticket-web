source 'https://rubygems.org'

#ruby=ruby-1.9.3-p484
#ruby-gemset=tocticket-web
gem 'rails', '3.2.13'
gem 'pg'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
gem 'jquery-rails', "~> 2.3.0"
gem 'jquery-ui-rails'
gem "thin", ">= 1.5.0"
gem "haml", ">= 3.1.7"

gem "bootstrap-sass", ">= 2.1.0.1"
gem "devise", "3.1.0"
gem 'omniauth'
gem 'oauth2'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem "cancan", ">= 1.6.8"
gem "rolify", ">= 3.2.0"
gem "simple_form", ">= 2.0.4"
gem "therubyracer", ">= 0.10.2", :group => :assets, :platform => :ruby
gem 'activeadmin'
gem "capistrano"
gem "rvm-capistrano"
# Images uploading
gem "rmagick"     # sudo apt-get update
                  # sudo apt-get install libmagickwand-dev
gem "carrierwave"

gem "lebops", git: "git@labs.lebrijo.com:lebops.git"

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem "haml-rails"
  gem "hpricot"
  gem "ruby_parser"
  gem "railroady"
  gem "quiet_assets"
end

group :test, :development do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem "factory_girl_rails"
end
group :test do
  gem "email_spec"
  gem "cucumber-rails", :require => false
  gem "database_cleaner"
  gem "launchy"
  gem "capybara"
end
