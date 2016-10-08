source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.0'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'settingslogic'
gem 'factory_girl_rails'
gem 'activeadmin', '~> 1.0.0.pre4'
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
gem 'ransack',             github: 'activerecord-hackery/ransack'
gem 'draper',              '> 3.x'
gem 'sass-rails',          github: 'rails/sass-rails'
gem 'devise'
gem 'bcrypt'
gem 'flexirest'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'awesome_print'
  gem 'rubocop', require: false
  gem 'guard-rubocop', require: false
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate'
end
