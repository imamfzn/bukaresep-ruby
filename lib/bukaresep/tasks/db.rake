# frozen_string_literal: true

require 'sqlite3'
require 'bukaresep/config_loader'

namespace :db do
  desc 'Create recipe table'
  task :create do

    # open config file
    config_filename = File.expand_path('../../../config.yml', File.dirname(__FILE__))

    # read db filename from config file
    db_filename = Bukaresep::ConfigLoader::load(config_filename)

    db = SQLite3::Database.open(db_filename)

    puts "Creating recipe schema/table on #{db_filename}"

    # executing sql syntax to create recipe schema if schema doesnt exists
    db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS recipe (
        recipe_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        recipe_name TEXT NOT NULL,
        recipe_description TEXT NOT NULL,
        recipe_ingredients TEXT NOT NULL,
        recipe_instructions TEXT NOT NULL
        );
      SQL

      puts "schema has been created on #{db_filename}"
  end

  task :drop do
    # open config file
    config_filename = File.expand_path('../../../config.yml', File.dirname(__FILE__))

    # read db filename from config file
    db_filename = Bukaresep::ConfigLoader::load(config_filename)

    db = SQLite3::Database.open(db_filename)

    puts "Dropping recipe table from #{db_filename}"

    db.execute <<-SQL
      DROP TABLE IF EXISTS recipe;
      SQL

    puts "schema has been dropped on #{db_filename}"

  end
end