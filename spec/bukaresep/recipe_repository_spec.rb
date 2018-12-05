# frozen_string_literal: true

RSpec.describe Bukaresep::RecipeRepository do
  let(:db){ double('database instance mock') }
  let(:repository){ described_class.new(db) }

  let(:id){ 1 }
  let(:name){ 'chicken katsu' }
  let(:desc){ 'oriental food' }
  let(:ingredients){ 'chciken katsu ingredients' }
  let(:instructions){ 'chicken katsu instructions' }

  let(:row){ [id, name, desc, ingredients, instructions] }

  let(:valid_recipe){ Bukaresep::Recipe.new(name, desc, ingredients, instructions) }
  let(:inserted_recipe){ Bukaresep::Recipe.new(name, desc, ingredients, instructions, id) }
  let(:invalid_recipe){ Bukaresep::Recipe.new(nil, desc, ingredients, instructions) }

  describe '#insert recipe' do
    before(:each) do
      allow(db).to receive(:execute){ nil }
      allow(db).to receive(:last_insert_row_id){ id }
      allow(db).to receive(:get_first_row){ row }
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
        allow(db).to receive(:get_first_row){ row }
      end

      it{ expect(repository.get(id)).to eq(inserted_recipe) }
    end

    context 'get all recipe' do
      let(:rows) do
        [
          [1, name, desc, ingredients, instructions],
          [1, name, desc, ingredients, instructions],
          [1, name, desc, ingredients, instructions]
        ]
      end

      before(:each) do
        allow(db).to receive(:execute){ rows }
      end

      it{ expect(repository.all).to be_an_instance_of(Array) }
      it{ expect(repository.all).to all(be_an(Bukaresep::Recipe)) }
    end

  end

  describe '#update recipe' do
    let(:updated_name){ 'chicken katsu v2.0.0' }
    let(:updated_row){ [id, updated_name, desc, ingredients, instructions] }
    let(:updated_recipe){ Bukaresep::Recipe.new(updated_name, desc, ingredients, instructions, id) }

    before(:each) do
      allow(db).to receive(:execute){ nil }
      allow(db).to receive(:get_first_row){ updated_row }
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
