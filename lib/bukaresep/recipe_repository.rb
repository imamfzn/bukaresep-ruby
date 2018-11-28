require "sqlite3"
require "recipe"
require "repository"

DB_PATH = '/home/imam/bukalapak/probation/bukaresep-ruby/bukaresep.db'

module Bukaresep
	class RecipeRepository < Repository
		def initialize
			@db = SQLite3::Database.new DB_PATH
		end

		# get recipe row by recipe_id
		def get(id)
			row = @db.get_first_row('SELECT * FROM recipe WHERE recipe_id = ?', [id])
			to_recipe(row)
		end

		# get all recipes
		def get_all()
			rows = @db.execute('SELECT * FROM recipe')
			recipes = rows.map {|row| to_recipe(row) }
		end

		# add / insert new recipe
		def add(recipe)
			@db.execute('INSERT INTO recipe (recipe_name, recipe_description, recipe_ingredients, recipe_instructions) 
				VALUES (?,?,?,?)', [recipe.name, recipe.description, recipe.ingredients, recipe.instructions])
		end

		# update / modify recipe value
		def update(recipe)
			@db.execute('UPDATE recipe SET recipe_name = ?, recipe_description = ?, recipe_ingredients = ?, recipe_instructions = ?
				WHERE recipe_id = ?', [recipe.name, recipe.description, recipe.ingredients, recipe.instructions, recipe.id])
		end

		# remove recipe by recipe_id
		def delete(id)
			@db.execute('DELETE FROM recipe WHERE recipe_id = ?', [id])
		end

		# transform recipe row to Recipe instance
		def to_recipe(row)
			Recipe.new(row[0], row[1], row[2], row[3], row[4])
		end
	end
end