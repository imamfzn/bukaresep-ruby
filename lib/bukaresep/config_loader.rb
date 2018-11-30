# frozen_string_literal: true

require 'yaml'

module Bukaresep

  # Class for handle all configuration for buekaresep gem
  # This class is needed for get database filename sqlite3
  class ConfigLoader

    # Load is the only method for this class to get database filename from config file
    #
    # @param [String] config_filename: a path of bukaresep configuration
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
