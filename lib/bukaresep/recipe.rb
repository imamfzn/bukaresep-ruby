require 'json'

module Bukaresep
	class Recipe
		attr_reader		:id
		attr_accessor 	:name, :description, :ingredients, :instructions

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

		def valid?
			return false if (@name.nil? || @name == "" || @description.nil? || @description == "" || 
				@ingredients.nil? || @ingredients == "" || @instructions.nil? || @instructions == "")

			return true
		end
	end
end