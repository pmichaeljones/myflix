source 'https://rubygems.org'
ruby '2.1.1'

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'bcrypt'
gem 'bootstrap_form'
gem "faker"
gem "fabrication"
gem 'pg'
gem 'sidekiq'
gem 'unicorn'
gem 'sinatra'
gem 'sentry-raven'
gem 'paratrooper'



group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
end

group :development, :test do
  gem 'rspec-rails', '2.99'
  gem 'pry', '0.9.10'
  gem 'pry-nav'
  gem 'letter_opener'
  gem 'capybara-email'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'shoulda'
  gem 'shoulda-matchers', require: false
  gem 'database_cleaner', '1.2.0'
end

group :production do
  gem 'rails_12factor'
end

