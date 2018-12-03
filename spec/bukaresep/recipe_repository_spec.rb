# frozen_string_literal: true

RSpec.describe Bukaresep::RecipeRepository do
  let(:db){ double('database instance mock') }
  let(:repository){ described_class.new(db) }

  let(:recipe_id){ 1 }
  let(:recipe_name){ 'chicken katsu' }
  let(:recipe_desc){ 'oriental food' }
  let(:recipe_ingredients){ 'chciken katsu ingredients' }
  let(:recipe_instructions){ 'chicken katsu instructions' }

  let(:recipe_row){ [recipe_id, recipe_name, recipe_desc, recipe_ingredients, recipe_instructions] }

  let(:valid_recipe){ Bukaresep::Recipe.new(recipe_name, recipe_desc, recipe_ingredients, recipe_instructions) }
  let(:inserted_recipe){ Bukaresep::Recipe.new(recipe_name, recipe_desc, recipe_ingredients, recipe_instructions, recipe_id) }
  let(:invalid_recipe){ Bukaresep::Recipe.new(nil, recipe_desc, recipe_ingredients, recipe_instructions) }

  describe '#insert recipe' do
    before(:each) do
      allow(db).to receive(:execute){ nil }
      allow(db).to receive(:last_insert_row_id){ recipe_id }
      allow(db).to receive(:get_first_row){ recipe_row }
    end

    context 'insert valid recipe' do
      it{ expect(repository.add(valid_recipe)).to_not be_nil }
      it{ expect(repository.add(valid_recipe)).to eq(inserted_recipe) }
    end

    context 'insert invalid recipe' do
      it{ expect{ repository.add(invalid_recipe) }.to raise_error(TypeError) }
    end

  end

  describe 'get recipe' do
    context 'get recipe by id' do
      before(:each) do
        allow(db).to receive(:get_first_row){ recipe_row }
      end

      it{ expect(repository.get(recipe_id)).to eq(inserted_recipe) }
    end

    context 'get all recipe' do
      let(:recipe_rows) do
        [
          [1, recipe_name, recipe_desc, recipe_ingredients, recipe_instructions],
          [1, recipe_name, recipe_desc, recipe_ingredients, recipe_instructions],
          [1, recipe_name, recipe_desc, recipe_ingredients, recipe_instructions]
        ]
      end

      before(:each) do
        allow(db).to receive(:execute){ recipe_rows }
      end

      it{ expect(repository.all).to be_an_instance_of(Array) }
      it{ expect(repository.all).to all(be_an(Bukaresep::Recipe)) }
    end

  end

  describe '#update recipe' do
    let(:updated_recipe_name){ 'chicken katsu v2.0.0' }
    let(:updated_recipe_row){ [recipe_id, updated_recipe_name, recipe_desc, recipe_ingredients, recipe_instructions] }
    let(:updated_recipe){ Bukaresep::Recipe.new(updated_recipe_name, recipe_desc, recipe_ingredients, recipe_instructions, recipe_id) }

    before(:each) do
      allow(db).to receive(:execute){ nil }
      allow(db).to receive(:get_first_row){ updated_recipe_row }
    end

    context 'update recipe' do
      it{ expect(repository.update(updated_recipe)).to eq(updated_recipe) }
    end

  end

  describe '#delete recipe' do
    before(:each) do
      allow(db).to receive(:execute){ nil }
    end

    context 'delete recipe by id' do
      it{ expect(repository.delete(valid_recipe)).to be true }
    end

  end

end
