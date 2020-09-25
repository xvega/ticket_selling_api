source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
gem 'mysql2', '>= 0.4.4'
gem 'puma', '~> 4.1'

gem 'bootsnap', '>= 1.4.2', require: false

gem 'responders'
gem 'active_model_serializers'

# API swagger docs
gem 'rswag'
gem 'rswag-api'
gem 'rswag-ui'

gem 'rack-cors'

gem 'fast_jsonapi'

gem 'kaminari'
gem 'api-pagination'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot'
  gem 'rspec-rails'
  gem 'rswag-specs'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
