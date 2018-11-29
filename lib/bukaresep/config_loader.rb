# frozen_string_literal: true

require 'yaml'

module Bukaresep

  # Class for handle all configuration for this gem
  class ConfigLoader
    def self.load(config_filename)
      config = YAML.load_file(config_filename)
      environment = ENV['RACK_ENV'] || 'development'
      filename = config[environment]['database']['filename']

      filename
    rescue SystemCallError
      $stderr.print "Error on read file from #{config_file}\n"
      raise
    end
  end

end