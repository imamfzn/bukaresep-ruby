# frozen_string_literal: true

RSpec.describe Bukaresep::Service do

  # mock of Bukaresep::RecipeFactory
  let(:recipe_repository){ double }

  # add mock repository to service
  let(:service){ described_class.new(recipe_repository) }

  # sample recipe data
  let(:valid_recipe){ Bukaresep::Recipe.new('food1', 'recipe desc', 'recipe ingredients', 'recipe instructions') }
  let(:invalid_recipe){ Bukaresep::Recipe.new(nil, 'recipe desc', 'recipe ingredients', 'recipe instructions') }

  describe '#add' do
    before(:each) do
      # add stub 'add' to mock Bukaresep::RecipeFactory
      allow(recipe_repository).to receive(:add){ Bukaresep::Recipe.new }
    end

    context 'valid recipe' do
      it do
        expect(recipe_repository).to receive(:add)
        expect(service.add('food name', 'food desc', 'food ingredients', 'food instructions')).to be_truthy
      end
    end

    context 'invalid recipe' do
      it do
        expect(recipe_repository).to_not receive(:add)
        expect(service.add(nil, 'food desc', 'food ingredients', 'food instructions')).to be false
      end
    end
  end

  describe '#get' do
    context 'get recipe by id' do
      let(:recipe){ Bukaresep::Recipe.new('food1', 'recipe desc', 'recipe ingredients', 'recipe instructions', 1) }

      before(:each) do
        allow(recipe_repository).to receive(:get){ recipe }
      end

      it{ expect(service.get(1)).to eq(recipe) }
    end

    context 'get all recipe' do
      let(:recipes) do
        [
          Bukaresep::Recipe.new('food1', 'recipe desc', 'recipe ingredients', 'recipe instructions', 1),
          Bukaresep::Recipe.new('food1', 'recipe desc', 'recipe ingredients', 'recipe instructions', 2),
          Bukaresep::Recipe.new('food1', 'recipe desc', 'recipe ingredients', 'recipe instructions', 3)
        ]
      end

      before(:each) do
        allow(recipe_repository).to receive(:all){ recipes }
      end

      it{ expect(service.all).to be_an_instance_of(Array) }
      it{ expect(service.all).to all(be_an(Bukaresep::Recipe)) }
    end
  end

  describe '#update' do
    before(:each) do
      #  add stub 'update' to mock Bukaresep::RecipeFactory
      allow(recipe_repository).to receive(:update){ Bukaresep::Recipe.new }
    end

    context 'valid recipe' do
      it do
        expect(recipe_repository).to receive(:update)
        expect(service.update(valid_recipe)).to be_truthy
      end
    end

    context 'invalid recipe' do
      it do
        expect(recipe_repository).to_not receive(:update)
        expect(service.update(invalid_recipe)).to be false
      end
    end
  end

end
