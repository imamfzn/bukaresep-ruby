RSpec.describe Bukaresep::Recipe do
	describe '#valid' do
		context 'valid recipe' do
			recipe = described_class.new('chicken katsu', 'a delicious japaneese food', 'chicken katsu ingredients', 'chicken katsu instructions')

			it { expect(recipe.valid?).to eq(true) }
		end

		context 'recipe with nil name' do
			recipe = described_class.new(nil, 'a delicious japaneese food', 'chicken katsu ingredients', 'chicken katsu instructions')

			it { expect(recipe.valid?).to eq(false) }
		end

		context 'recipe with empty string name' do
			recipe = described_class.new('', 'a delicious japaneese food', 'chicken katsu ingredients', 'chicken katsu instructions')

			it { expect(recipe.valid?).to eq(false) }
		end

		context 'recipe with nil description' do
			recipe = described_class.new('chicken katsu', nil, 'chicken katsu ingredients', 'chicken katsu instructions')


			it { expect(recipe.valid?).to eq(false) }
		end

		context 'recipe with empty string description' do
			recipe = described_class.new('chicken katsu', '', 'chicken katsu ingredients', 'chicken katsu instructions')


			it { expect(recipe.valid?).to eq(false) }
		end

		context 'recipe with nil ingredients' do
			recipe = described_class.new('chicken katsu', 'a delicious japaneese food', nil, 'chicken katsu instructions')

			it { expect(recipe.valid?).to eq(false) }
		end

		context 'recipe with empty string ingredients' do
			recipe = described_class.new('chicken katsu', 'a delicious japaneese food', '', 'chicken katsu instructions')

			it { expect(recipe.valid?).to eq(false) }
		end

		context 'recipe with nil instructions' do
			recipe = described_class.new('chicken katsu', 'a delicious japaneese food', 'chicken katsu ingredients', nil)

			it { expect(recipe.valid?).to eq(false) }
		end

		context 'recipe with empty string instructions' do
			recipe = described_class.new('chicken katsu', 'a delicious japaneese food', 'chicken katsu ingredients', '')

			it { expect(recipe.valid?).to eq(false) }
		end
	end
end