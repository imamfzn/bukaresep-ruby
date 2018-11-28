module Bukaresep
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

			@service.add(recipe)
		end

		def update(recipe)
		end 

		def delete(recipe)
		end
	end
end