# app/main.rb

require_relative 'pokemon_scraper'
require_relative 'data_saver'

module Main
  def self.run
    scraper = PokemonScraper.new
    pokemons = scraper.scrape_data
    data_saver = DataSaver.new(pokemons, 'result.json')
    data_saver.save
    puts 'Scraping completed. Data saved to result.json.'
  end
end

Main.run if __FILE__ == $PROGRAM_NAME