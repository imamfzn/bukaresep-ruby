# frozen_string_literal: true

module Bukaresep

  # Repository is a class like an interface that represent / wrap access to data source
  class Repository
    def get(_id)
      raise 'please implement get method'
    end

    def get_all
      raise 'please implement get_all method'
    end

    def add(_recipe)
      raise 'please implement add method'
    end

    def update(_recipe)
      raise 'please implement update method'
    end

    def delete(_id)
      raise 'please implement delete method'
    end
  end
end
