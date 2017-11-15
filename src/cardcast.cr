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
end
