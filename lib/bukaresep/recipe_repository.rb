require "sqlite3"
require "bukaresep/recipe"
require "bukaresep/repository"

DB_PATH = '/home/imam/bukalapak/probation/bukaresep-ruby/bukaresep.db'

module Bukaresep
	class RecipeRepository < Bukaresep::Repository
		def initialize(db_path)
			@db = SQLite3::Database.new DB_PATH
		end

		# get recipe row by recipe_id
		def get(id)
			begin
				row = @db.get_first_row('SELECT * FROM recipe WHERE recipe_id = ?', [id])
				
				return nil if row == nil

				return to_recipe(row)
			rescue SQLite3::Exception => execption
				raise exception
			end
		end

		# get all recipes
		def get_all()
			begin
				rows = @db.execute('SELECT * FROM recipe')
				recipes = rows.map { |row| to_recipe(row) }
			rescue SQLite3::Exception => exception
				raise exception
			end
		end

		# add / insert new recipe
		def add(recipe)
			raise TypeError, 'Invalid recipe' unless recipe.valid?	

			begin
				@db.execute('INSERT INTO recipe (recipe_name, recipe_description, recipe_ingredients, recipe_instructions) 
					VALUES (?,?,?,?)', [recipe.name, recipe.description, recipe.ingredients, recipe.instructions])
				
				get(@db.last_insert_row_id)
			rescue SQLite3::Exception => exception
				raise exception
			end
		end

		# update / modify recipe value
		def update(recipe)
			begin
				@db.execute('UPDATE recipe SET recipe_name = ?, recipe_description = ?, recipe_ingredients = ?, recipe_instructions = ?
					WHERE recipe_id = ?', [recipe.name, recipe.description, recipe.ingredients, recipe.instructions, recipe.id])

				get(recipe.id)
			rescue SQLite3::Exception => exception
				raise exception
			end
		end

		# remove recipe by recipe_id
		def delete(id)
			begin
				@db.execute('DELETE FROM recipe WHERE recipe_id = ?', [id])
			rescue SQLite3::Exception => exception
				raise exception
			end

			return true
		end

		# transform recipe row to Recipe instance
		def to_recipe(row)
			Bukaresep::Recipe.new(row[0], row[1], row[2], row[3], row[4])
		end
	end
end