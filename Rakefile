# frozen_string_literal: true

require 'bundler'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

task default: %w[test]

desc 'Test: run specs & rubocop'
task test: %i[spec rubocop]

desc 'Run specs'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--require ./spec/spec_helper'
end

desc 'Lint code'
RuboCop::RakeTask.new

Bundler::GemHelper.install_tasks