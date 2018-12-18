# bukaresep-ruby

A simple gem to manage food recipes

## Installation

Include the gem in your Ruby app's `Gemfile`:

```ruby
gem "bukaresep", :git => "https://github.com/imamfzn/bukaresep-ruby.git", :branch => "development"
```

Then do a `bundle install`.

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
* id (integer, required),

## Usage

Set up bukaresep dependency first:

```ruby
require 'bukaresep'
require 'sqlite3'

# define your db sqlite filename / path
# bukaresep will automatically creating necessary table if not exists
filename = 'example-db-filename.sqlite3'

# create db instance from sqlite3 using db filename
db = SQLite3::Database.new(filename)

# create recipe repository for data access
repository = Bukaresep::RecipeRepository.new(db)

# finally create recipe service
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
recipe = recipe_service.get(1) # the recipe's id
```

### List all recipes

```ruby
recipes = recipe_service.all
```

### Delete a recipe

```ruby
recipe_service.delete(1) # the recipe;s id
```

## Onboarding & Development Guide

### Prerequisite

1. Git
2. Ruby
3. Bundler
4. SQLite3

### Setup

1. Clone this repository
```bash
git clone -b development https://github.com/imamfzn/bukaresep-ruby.git
```
2. Install required modules
```bash
bundle install
```
3. Build & Install Gem
```bash
rake install
```

### Development Guide

#### Using rake
1. Run ```rake test``` to test the gem (spec / unit test & rubocop lint)