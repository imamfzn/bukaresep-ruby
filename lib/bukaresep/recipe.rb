# frozen_string_literal: true

require 'json'

module Bukaresep

  # Class as recipe representation
  class Recipe
    attr_accessor :id, :name, :description, :ingredients, :instructions

    # Initialize is a constructor of this class instance
    #
    # @param [String] name: represent food name
    # @param [String] description: represent recipe of food description
    # @param [String] ingredients: represent ingredients that need for making particular food
    # @param [String] instructions: represent steps to make particular food
    # @param [Integer] id: key of recipe, it is generated from sqlite3 with autoincrement

    def initialize(name = '', description = '', ingredients = '', instructions = '', id = nil)
      @id           = id
      @name         = name
      @description  = description
      @ingredients  = ingredients
      @instructions = instructions
    end

    # To json will transform recipe instance to json string format
    #
    # @return [String] recipe in json format
    def to_json
      { id: @id, name: @name, description: @description, ingredients: @ingredients, instructions: @instructions }.to_json
    end

    # == is a override method from equality method to check equality between two recipes instance
    #
    # Raise [TypeError] when other is not instance of Recipe
    # @param [Recipe] other: Recipe instance to be check equality

    def ==(other)
      raise TypeError, 'Other mas be a Recipe' unless other.instance_of? Recipe

      @id == other.id &&
        @name == other.name &&
        @description == other.description &&
        @ingredients == other.ingredients &&
        @instructions == other.instructions
    end

    # Valid is a method to check recipe following requirement
    # Recipe will valid if value of all attributes not nil / empty string except id
    #
    # @return true if equal and vice versa
    def valid?
      return false if @name.nil? || @name == '' || @description.nil? || @description == '' || @ingredients.nil? || @ingredients == '' || @instructions.nil? || @instructions == ''

      true
    end
  end
end
