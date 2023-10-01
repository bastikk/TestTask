# spec/data_saver_spec.rb

require './app/data_saver'

RSpec.describe DataSaver do
  let(:data_saver) { described_class.new(pokemons, filename) }
  let(:filename) { 'test.json' }

  context ".save" do
    let(:pokemons) do
      [
        { 'id' => 1, 'name' => 'Pokemon1' },
        { 'id' => 2, 'name' => 'Pokemon2' }
      ]
    end

    # Call the method
    before { data_saver.save }

    it 'saves data to a JSON file' do
      # Check if the file exists
      expect(File.exist?('test.json')).to be true
      # Check if the content in the file matches the expected data
      expect(JSON.parse(File.read(filename))).to eq(pokemons)
    end

    # Clean up the test file after the test
    after {  File.delete(filename) }
  end
end
