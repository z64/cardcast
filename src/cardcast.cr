require "http/client"
require "./cardcast/*"

module CardCast
  # URL to the CardCast API
  API_URL = "https://api.cardcastgame.com/v1"

  # Returns metadata about a particular deck as a `DeckInfo`
  def self.deck(code : String)
    response = HTTP::Client.get "#{API_URL}/decks/#{code}"
    DeckInfo.from_json(response.body)
  end

  # Returns the cards in a particular deck (see `Deck`)
  def self.cards(code : String)
    response = HTTP::Client.get "#{API_URL}/decks/#{code}/cards"
    Deck.from_json(response.body)
  end

  # Searches for decks based on a search term.
  # Endpoint is paginated with the `offset` and `limit` arguments.
  # NOTE: The max `limit` is 50.
  def self.search(query : String = "", offset = 0, limit = 20)
    params = HTTP::Params.build do |form|
      form.add "search", query
      form.add "offset", offset.to_s
      form.add "limit", limit.to_s
    end

    response = HTTP::Client.get "#{API_URL}/decks?#{params}"

    parser = JSON::PullParser.new(response.body)

    results = nil
    parser.on_key("results") do
      results = SearchResults.new(parser)
    end

    results
  end
end
