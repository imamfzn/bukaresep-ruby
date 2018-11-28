require 'sqlite3'

namespace :db do
	desc 'Create recipe table'
	task :create_schema do
		db = SQLite3::Database.open('bukaresep.db')

		puts "creating recipe schema / table"


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

	   	puts "schema has been created"
	end
end