require 'nokogiri'
require 'httparty'
require './app/rate_limiter'

class PokemonScraper
  BASE_URL = 'https://scrapeme.live/shop/page/'
  POKEMON_SELECTOR = 'ul.products.columns-4 li'

  def initialize(start_page: 1, rate_limiter: 5)
    @page = start_page
    @limiter = RateLimiter.new(rate_limiter)
    @pokemons = []
  end

  def scrape_data
    loop do
      loop do
        break if @limiter.allow_request?
        sleep 0.01
      end
      response = HTTParty.get("#{BASE_URL}#{@page}/")

      break if response.code != 200

      html = Nokogiri::HTML(response.body)
      parse_pokemons(html)
      @page += 1
    end

    @pokemons.uniq { |pokemon| pokemon['id'] }
  end

  private

  def parse_pokemons(html)
    html.css(POKEMON_SELECTOR).compact.each do |pokemon_data|
      pokemon = {
        'id' => pokemon_data.children[2]['data-product_id'],
        'name' => pokemon_data.at_css('h2').text.strip,
        'price' => pokemon_data.at_css('span.price span.woocommerce-Price-amount.amount').text.strip,
        'sku' => pokemon_data.children[2]['data-product_sku'],
        'image_url' => pokemon_data.at_css('img')['src']
      }
      @pokemons << pokemon
    end
  end
end