# frozen_string_literal: true

require 'bukaresep/recipe'

# All business logif of Bukaresep gem
module Bukaresep

  # Service is a class that represent this gem use cases
  # It is a class because a dependency (Bukaresep::RecipeRepository) is needed
  class Service

    # Initialize is a constructor of this class instance
    #
    # @param [RecipeRepository] service: an instance of Bukaresep::RecipeRepository
    def initialize(service)
      @service = service
    end

    # Get will retrieve a recipe with particular id from the storage
    #
    # @param [Integer] id: the id that will be retrieved from the storage
    # @return [Bukaresep::Recipe]: the retrieved recipe from storage
    def get(id)
      @service.get(id)
    end

    # Get all will retrieve all recipes from storage
    #
    # @return [Array[Bukaresep::Recipe]]: all recipe from the storage
    def get_all
      @service.get_all
    end

    # Add a new recipe to the storage
    #
    # @param [String] name: name of food for particular recipe
    # @param [String] description: description of food for particular recipe
    # @param [String] ingeredients: ingredients that needed to make particular food
    # @param [String] instructions: all steps to make particular food
    # @return [Bukaresep::Recipe]: a recipe created on the storage,
    #                              but will return false, if recipe is invalid
    def add(name, description, ingredients, instructions)
      recipe = Bukaresep::Recipe.new(name, description, ingredients, instructions)

      return false unless recipe.valid?

      @service.add(recipe)
    end

    # Update will modify old recipe value with current recipe
    #
    # @param [Bukaresep::Recipe] recipe: recipe that will be modify
    # @return [Bukaresep::Recipe]: a recipe has been updated on storage
    #                              but will return false, if recipe invalid
    def update(recipe)
      return false unless recipe.valid?

      @service.update(recipe)
    end

    # Delete will remove recipe from storage with particular id
    # @param [Integer] id: id of recipe that will be deleted from storage
    # @return true after deleting particular recipe
    def delete(id)
      @service.delete(id)
    end
  end

end
