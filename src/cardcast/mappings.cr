require "json"

module CardCast
  struct Card
    JSON.mapping(
      id: String,
      text: Array(String),
      created_at: {type: Time, converter: Time::Format::ISO_8601_DATE_TIME},
      nsfw: Bool
    )
  end

  module UInt32Converter
    def self.from_json(parser)
      parser.read_string.to_u32
    end
  end

  module FloatConverter
    def self.from_json(parser)
      parser.read_string.to_f32
    end
  end

  struct DeckInfo
    JSON.mapping(
      name: String,
      code: String,
      description: {type: String, default: ""},
      unlisted: {type: Bool, default: false},
      created_at: {type: Time, converter: Time::Format::ISO_8601_DATE_TIME},
      updated_at: {type: Time, converter: Time::Format::ISO_8601_DATE_TIME},
      external_copyright: Bool,
      copyright_holder_url: String?,
      category: String,
      call_count: {type: UInt32, converter: UInt32Converter},
      response_count: {type: UInt32, converter: UInt32Converter},
      author: DeckAuthor,
      rating: {type: Float32, converter: FloatConverter},
      sample_calls: {type: Array(Card), default: [] of Card},
      sample_responses: {type: Array(Card), default: [] of Card}
    )
  end

  struct DeckAuthor
    JSON.mapping(
      id: String,
      username: String
    )
  end

  struct Deck
    JSON.mapping(
      calls: Array(Card),
      responses: Array(Card)
    )
  end

  struct SearchResults
    JSON.mapping(
      count: UInt32,
      offset: UInt32,
      data: Array(DeckInfo)
    )
  end
end
