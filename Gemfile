# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github){ |repo_name| "https://github.com/#{repo_name}" }

gemspec

gem 'dotenv', '~>2.5.0', '>= 2.0.0'
gem 'rake', '~>12.3.1', '>= 12.3.0'
gem 'sqlite3', '~>1.3.13', '>= 1.3.0'

group :test, :development do
  gem 'bundler', '~>1.17.1', '>= 1.17.0'
  gem 'rspec', '~>3.8.0', '>= 3.8.0'
  gem 'rubocop', '~>0.60.0', '>= 0.60.0'
  gem 'simplecov', '~>0.16.1', '>= 0.16.0', require: false
end
