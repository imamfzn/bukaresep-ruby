# frozen_string_literal: true

require 'sqlite3'
require 'bukaresep/recipe'
require 'bukaresep/repository'

module Bukaresep

  # Implementation of Bukaresep::Repository
  # Repository that represent access to the data source
  class RecipeRepository < Bukaresep::Repository

    # Initialize is a construcotr of RecipeRepository
    #
    # @param [String] db_filename: a filename that represent database path for sqlite3
    def initialize(db_filename)
      @db = SQLite3::Database.new(db_filename)
    end

    # Get will retrive row recipe from database by particular id
    #
    # @param [Integer] id: the id of particular recipe
    # @return [Bukaresep::Recipe] is a transformed recipe row to recipe instance
    #                             but return nil if id not found
    def get(id)
      row = @db.get_first_row('SELECT * FROM recipe WHERE recipe_id = ?', [id])

      return nil if row.nil?

      to_recipe(row)
    rescue SQLite3::Exception => exception
      raise exception
    end

    # All will retrieve all rows from recipe table
    #
    # @return [Array[Bukaresep::Recipe]] is a transformed recipes instance from rows of recipe
    def all
      begin
        rows = @db.execute('SELECT * FROM recipe')
        recipes = rows.map{ |row| to_recipe(row) }
      rescue SQLite3::Exception => exception
        raise exception
      end

      recipes
    end

    # Add will insert new recipe row to recipe table
    #
    # Raise [TypeError] when recipe is not valid
    # @param [Bukaresep::Recipe] recipe: recipe instance that will be insert to databases
    # @return [Bukaresep::Recipe] an inserted recipe instance with recipe id from database
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

    # Update will change row values by current recipe value
    #
    # @param [Bukaresep::Recipe] recipe: recipe instance that represent current value
    # @return [Bukaresep::Recipe] recipe: updated recipe instance
    def update(recipe)
      @db.execute('UPDATE recipe SET recipe_name = ?, recipe_description = ?, recipe_ingredients = ?, recipe_instructions = ?
        WHERE recipe_id = ?', [recipe.name, recipe.description, recipe.ingredients, recipe.instructions, recipe.id])

      get(recipe.id)
    rescue SQLite3::Exception => exception
      raise exception
    end

    # Delete will remove recipe row from database using particular id
    #
    # @param [Integer] id: row id that will be removed from database
    # @return true after row deleted / row not found by particular id
    def delete(id)
      begin
        @db.execute('DELETE FROM recipe WHERE recipe_id = ?', [id])
      rescue SQLite3::Exception => exception
        raise exception
      end

      true
    end

    # To recipe will transform row from recipe table to recipe instance
    #
    # @param [SQLite3 Result Row]
    # @return [Bukaresep::Recipe] a transformed row to recipe instance
    def to_recipe(row)
      Bukaresep::Recipe.new(row[1], row[2], row[3], row[4], row[0])
    end
  end
end
