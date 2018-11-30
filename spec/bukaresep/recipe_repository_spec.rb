RSpec.describe Bukaresep::RecipeRepository do
  # read db filename from config file
  let(:db_filename) { Bukaresep::ConfigLoader::load }

  let(:repository) { described_class.new(db_filename) }

  describe '#insert_recipe' do
    let(:valid_recipe)  { Bukaresep::Recipe.new('food1', 'recipe desc', 'recipe ingredients', 'recipe instructions') }
    let(:invalid_recipe) { Bukaresep::Recipe.new(nil, 'recipe desc', 'recipe ingredients', 'recipe instructions') }

    context 'insert valid recipe' do
      it 'return new recipe object (not nil)' do

        actual = repository.add(valid_recipe)

        expect(actual).to_not be_nil
        expect(actual.name).to eq(valid_recipe.name)
        expect(actual.description).to eq(valid_recipe.description)
        expect(actual.ingredients).to eq(valid_recipe.ingredients)
        expect(actual.instructions).to eq(valid_recipe.instructions)
      end
    end

    context 'insert invalid recipe' do
      it { expect { repository.add(invalid_recipe) }.to raise_error(TypeError) }
    end
  end

  describe '#querying recipe' do
    let(:recipes) do
      [
        Bukaresep::Recipe.new('Recipe name', 'Recipe desc', 'Recipe ingredients', 'Recipe instructions'),
        Bukaresep::Recipe.new('Recipe name', 'Recipe desc', 'Recipe ingredients', 'Recipe instructions'),
        Bukaresep::Recipe.new('Recipe name', 'Recipe desc', 'Recipe ingredients', 'Recipe instructions'),
        Bukaresep::Recipe.new('Recipe name', 'Recipe desc', 'Recipe ingredients', 'Recipe instructions')
      ]
    end

    before(:each) do
      recipes.each do |recipe|
        added_recipe = repository.add(recipe)
        recipe.id = added_recipe.id
      end
    end

    context '#get_recipe_by_id' do
      context 'get by same id' do
        it 'returns same recipe object' do
          recipes.each do |recipe|
            found_recipe = repository.get(recipe.id)
            expect(recipe).to eq(found_recipe)
          end
        end
      end

      context 'id not exists' do
        it { expect(repository.get(-1)).to be_nil }
      end
    end

    context 'get all recipe' do
      it { expect(repository.get_all).to be_an_instance_of(Array) }
      it { expect(repository.get_all).to all(be_an(Bukaresep::Recipe)) }
    end

    context 'update recipe' do
      it 'return updated recipe' do
        expected = recipes[0].dup
        expected.name = 'updated name'
        expected.description = 'updated description'
        actual = repository.update(expected)

        expect(actual).to eq(expected)
      end
    end

    context 'delete recipe by id' do
      it { expect(repository.delete(recipes[0].id)).to be true }
    end
  end
end