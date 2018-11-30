# frozen_string_literal: true

require 'bukaresep/recipe'

module Bukaresep

  # Class that wrap all use cases
  class Service
    def initialize(service: nil)
      @service = service
    end

    def get(id)
      @service.get(id)
    end

    def get_all
      @service.get_all
    end

    def add(name, description, ingredients, instructions)
      recipe = Bukaresep::Recipe.new(name, description, ingredients, instructions)

      return false unless recipe.valid?

      @service.add(recipe)
    end

    def update(recipe)
      return false unless recipe.valid?

      @service.update(recipe)
    end

    def delete(id)
      @service.delete(id)
    end
  end

end
