# spec/pokemon_scraper_service_spec.rb

require './app/main'

RSpec.describe Main do
  let(:pokemon_scraper) { instance_double(PokemonScraper) }
  let(:data_saver) { instance_double(DataSaver) }

  before do
    expect(PokemonScraper).to receive(:new).and_return(pokemon_scraper)
    expect(pokemon_scraper).to receive(:scrape_data).and_return(['Pokemon1', 'Pokemon2'])
    expect(DataSaver).to receive(:new).with(['Pokemon1', 'Pokemon2'], 'result.json').and_return(data_saver)
    expect(data_saver).to receive(:save)
  end

  it { expect { Main.run }.to output("Scraping completed. Data saved to result.json.\n").to_stdout }
end
