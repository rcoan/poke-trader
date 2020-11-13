class Pokemon::Client
  POKE_API_URL = 'https://pokeapi.co/api/v2/pokemon'
  QUANTITY_PER_PAGE = 20

  def list(page_number)
    offset = (page_number-1) * QUANTITY_PER_PAGE
    response = HTTParty.get("#{POKE_API_URL}?offset=#{offset}&limit=#{QUANTITY_PER_PAGE}")

    {
      next_page: response[:next],
      previous_page: response[:previous],
      pokemons: response[:results]
    }
  end

  def fetch(id)
    HTTParty.get("#{POKE_API_URL}/#{id}")
  end
end