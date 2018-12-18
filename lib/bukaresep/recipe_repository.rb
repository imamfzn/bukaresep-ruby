# frozen_string_literal: true

require 'bukaresep/recipe'
require 'bukaresep/repository'

module Bukaresep

  # Implementation of Bukaresep::Repository
  # Repository that represent access to the data source
  class RecipeRepository < Bukaresep::Repository

    # Initialize is a constructor of RecipeRepository
    # It will setup recipe table if table is not present
    #
    # @param [SQLite3] db: an instance of sqlite3 database connection
    def initialize(db)
      @db = db

      create_table
    end

    # Get will retrive row recipe from database by particular id
    #
    # @param [Integer] id: the id of particular recipe
    # @return [Bukaresep::Recipe] is a transformed recipe row to recipe instance
    #                             but return nil if id not found
    def get(id)
      row = @db.get_first_row('SELECT * FROM recipe WHERE id = ?', [id])

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
        @db.execute('INSERT INTO recipe (name, description, ingredients, instructions)
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
      @db.execute('UPDATE recipe SET name = ?, description = ?, ingredients = ?, instructions = ?
        WHERE id = ?', [recipe.name, recipe.description, recipe.ingredients, recipe.instructions, recipe.id])

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
        @db.execute('DELETE FROM recipe WHERE id = ?', [id])
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

    private

    # Create table will creating recipe table
    # if table is not exists on database
    def create_table
      @db.execute('CREATE TABLE IF NOT EXISTS recipe (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        ingredients TEXT NOT NULL,
        instructions TEXT NOT NULL
        );')
    rescue SQLite3::Exception => exception
      raise exception
    end

  end
end
