source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.0'
gem 'mysql2'
gem 'puma'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'settingslogic'
gem 'factory_girl_rails'
gem 'activeadmin', '~> 1.0.0.pre4'
gem 'jquery-ui-rails', '~> 5.0.5'
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
gem 'ransack'
gem 'draper', '> 3.x'
gem 'sass-rails'
gem 'devise'
gem 'bcrypt'
gem 'flexirest'
gem 'active_admin_importable'
gem 'active_skin'

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
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'annotate'
end
