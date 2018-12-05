# frozen_string_literal: true

require 'sqlite3'
require 'bukaresep/config_loader'

namespace :db do
  desc 'Create recipe table'
  task :create do

    # read db filename from config file
    db_filename = Bukaresep::ConfigLoader.load

    db = SQLite3::Database.open(db_filename)

    puts "Creating recipe schema/table on #{db_filename}."

    # executing sql syntax to create recipe schema if schema doesnt exists
    db.execute('CREATE TABLE IF NOT EXISTS recipe (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        ingredients TEXT NOT NULL,
        instructions TEXT NOT NULL
        );')

    puts "Schema has been created on #{db_filename}."
  end

  desc 'Drop recipe table'
  task :drop do

    # read db filename from config file
    db_filename = Bukaresep::ConfigLoader.load

    db = SQLite3::Database.open(db_filename)

    puts "Dropping recipe table from #{db_filename}."

    db.execute('DROP TABLE IF EXISTS recipe')

    puts "Schema has been dropped on #{db_filename}."

  end
end
