# bukaresep-ruby

A simple gem to manage food recipes

## Installation

Include the gem in your Ruby app's `Gemfile`:

```ruby
gem "bukaresep", :git => "https://github.com/imamfzn/bukaresep-ruby.git", :branch => "development"
```

Then do a `bundle install`.

After that, create configuration file named `config.yml` that configure the database filename. Example look at `sample.config.yml`

### Migrate database

Include Bukaresep's `Rakefile` to your project's `Rakefile`:

```ruby
  spec = Gem::Specification.find_by_name 'bukaresep'
  rakefile = "#{spec.gem_dir}/lib/bukaresep/Rakefile"
  load rakefile
```

Then, do this:

```sh
rake db:create
```

## Dependency

This gem needs a SQLite3 database to store recipes.

## Scope

This gem should be able to:

* add a new recipe,
* update a recipe,
* retrieve detail of a recipe,
* list all recipe,
* delete recipe.

A recipe consists of:

* name (string, required),
* description (string, required),
* ingredients (string, required),
* instructions (string, required),
* ID (integer, required),

## Usage

Set up bukaresep dependency first:

```ruby
require 'bukaresep'

# load configuration file (config.yml) to get db filename
filename = Bukaresep::ConfigLoader::load
repository = Bukaresep::RecipeRepository.new
recipe_service = Bukaresep::Service.new(repository)
```

Then, you can use `bukaresep service` to manage your recipes.

### Add a new recipe

```ruby
recipe = recipe_service.add("Chicken Katsu", "Delicious oriental food", "Chicken, egg, salt", "Just merge all ingredients")
# recipe will contain a Recipe object from database.
```

### Update a Recipe

```ruby
recipe.name = "Chicken Katsu v2.0"
recipe = recipe_service.update(recipe)
```

### Retrieve detail of a recipe

```ruby
recipe = recipe_service.get(1) # the recipe's ID
```

### List all recipes

```ruby
reicipes = reicipe_service.get_all
```

### Delete a recipe

```ruby
recipe_service.delete(recipe)
```