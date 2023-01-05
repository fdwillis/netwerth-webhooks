source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.5"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.2", ">= 7.0.2.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"
gem 'stripe'
gem 'figaro'
gem 'whenever'
gem 'font-awesome-rails'
gem 'devise'
gem 'awesome_print'
gem 'clockwork'
gem 'localtunnel'
gem 'twilio-ruby'
gem 'oj'
gem 'byebug'

# Use postgresql as the database for Active Record
gem "pg"
gem 'rails_12factor', group: :production


# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 4.1'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "web-console"
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'letter_opener'
  gem 'test-unit'
  gem 'email_spec'
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'shoulda-matchers'
  gem 'shoulda'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'rspec-its'
  gem 'rspec'
end