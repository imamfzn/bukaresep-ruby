# frozen_string_literal: true

require 'yaml'

DEFAULT_CONFIG_FILENAME = 'config.yml'

module Bukaresep

  # Class for handle all configuration for buekaresep gem
  # This class is needed for get database filename sqlite3
  class ConfigLoader

    # Load is the only method for this class to get database filename from config file
    #
    # @return db sqlite3 filename
    def self.load
      config = YAML.load_file(DEFAULT_CONFIG_FILENAME)
      environment = ENV['RACK_ENV'] || 'development'
      filename = config[environment]['database']['filename']

      filename
    rescue SystemCallError
      $stderr.print "Error on read file from #{config_file}\n"
      raise
    end
  end

end
