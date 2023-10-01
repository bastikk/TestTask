# spec/pokemon_scraper_spec.rb

require './app/pokemon_scraper'
RSpec.describe PokemonScraper do
  let(:scraper) { described_class.new }

  before do
    # Stub the HTTParty.get method to return a 200 response for the first request
    expect(HTTParty).to receive(:get).with('https://scrapeme.live/shop/page/1/')
                                    .and_return(double(code: 200, body: '<html>Your HTML content</html>'))

    # Stub the HTTParty.get method to return a 400 response for the second request
    expect(HTTParty).to receive(:get).with('https://scrapeme.live/shop/page/2/')
                                    .and_return(double(code: 400, body: 'Bad Request'))
  end

  it 'scrapes data successfully' do
    pokemons = scraper.scrape_data

    expect(pokemons).to be_an(Array)
  end
end
