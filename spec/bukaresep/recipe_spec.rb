RSpec.describe Bukaresep::Recipe do
	describe '#valid' do

		# recipe value mock
		name 			= 'chicken katsu'
		desc 			= 'a delicious japaneese food'
		ingredients 	= 'chicken katsu ingredients'
		instructions	= 'chicken katsu instructions'

		context 'valid recipe' do
			recipe = described_class.new(name, desc, ingredients, instructions)

			it { expect(recipe.valid?).to eq(true) }
		end

		context 'recipe with nil name' do
			recipe = described_class.new(nil, desc, ingredients, instructions)

			it { expect(recipe.valid?).to eq(false) }
		end

		context 'recipe with empty string name' do
			recipe = described_class.new('',  desc, ingredients, instructions)

			it { expect(recipe.valid?).to eq(false) }
		end

		context 'recipe with nil description' do
			recipe = described_class.new(name, nil, ingredients, instructions)

			it { expect(recipe.valid?).to eq(false) }
		end

		context 'recipe with empty string description' do
			recipe = described_class.new(name, '', ingredients, instructions)

			it { expect(recipe.valid?).to eq(false) }
		end

		context 'recipe with nil ingredients' do
			recipe = described_class.new(name, desc, nil, ingredients)

			it { expect(recipe.valid?).to eq(false) }
		end

		context 'recipe with empty string ingredients' do
			recipe = described_class.new(name, desc, '', ingredients)

			it { expect(recipe.valid?).to eq(false) }
		end

		context 'recipe with nil instructions' do
			recipe = described_class.new(name, desc, ingredients, nil)

			it { expect(recipe.valid?).to eq(false) }
		end

		context 'recipe with empty string instructions' do
			recipe = described_class.new(name, desc, ingredients, '')

			it { expect(recipe.valid?).to eq(false) }
		end
	end

	describe '#equal' do
		recipe = described_class.new('food #1', 'recipe desc', 'recipe ingredients', 'recipe instructions')

		context 'same recipe' do
			recipe_dup = recipe.dup

			it { expect(recipe).to eq recipe_dup }
		end
		
		context 'different recipe' do
			recipe_diff = described_class.new('food #2', 'recipe desc', 'recipe ingredients', 'recipe instructions')

			it { expect(recipe).to_not eq recipe_diff }
		end

		context 'different type' do
			recipe_diff_type =  { }

			it { expect { recipe == recipe_diff_type }.to raise_error(TypeError) }
		end
	end	
end