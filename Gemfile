source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.4"
gem "mysql2"
gem "puma", "< 6"
gem 'faraday' # HTTP requests
gem 'typhoeus' # Faraday http adapter
gem 'rack' # HTTP response compression
gem 'rack-cors' # CORS handling
gem "webrick", "~> 1.7"
gem 'ununiga' # i18n 은는이가
gem 'bcrypt'
gem 'jwt'

gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  gem 'byebug', platforms: %i(mri mingw x64_mingw), require: false
  gem 'factory_bot_rails' # fixtures replacement; support for multiple build strategies
  gem 'faker' # Generates fake data.
  gem 'rspec-rails', '~> 6.0.0.rc1' # RSpec testing framework to Ruby on Rails
  gem 'rubocop', require: false # Ruby static code analyzer
  gem 'rubocop-rails', require: false # rubocop extensions for rails convention
  gem 'shoulda-matchers'
end

group :development do
  gem 'listen', '~> 3.7.1' # notification about file modify
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
