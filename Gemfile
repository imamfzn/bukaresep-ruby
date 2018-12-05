# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github){ |repo_name| "https://github.com/#{repo_name}" }

gemspec

gem 'rake', '~>12.3.1'
gem 'sqlite3', '~>1.3.13'

group :test :development do
  gem 'bundler'
  gem 'rspec', '~>3.8.0'
  gem 'rubocop', '~>0.60.0'
  gem 'simplecov', '~>0.16.1', require: false
end
