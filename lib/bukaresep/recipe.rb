require 'json'

module Bukaresep
	class Recipe
		attr_accessor :id, :name, :description, :ingredients, :instructions

		def initialize(id = nil, name, description, ingredients, instructions)
			@id 			= id
			@name 			= name
			@description 	= description
			@ingredients	= ingredients
			@instructions	= instructions
		end

		def to_json
			{ id: @id, name: @name, description: @description, ingredients: @ingredients, instructions: @instructions }.to_json
		end

		def ==(other)
			raise TypeError, 'Other mas be a Recipe' unless other.instance_of? Recipe

			@id == other.id && 
				@name == other.name &&
				@description == other.description &&
				@ingredients == other.ingredients &&
				@instructions == other.instructions
		end

		def valid?
			return false if (@name.nil? || @name == "" || @description.nil? || @description == "" || 
				@ingredients.nil? || @ingredients == "" || @instructions.nil? || @instructions == "")

			return true
		end
	end
end