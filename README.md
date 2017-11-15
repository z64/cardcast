# cardcast

A simple API binding to the CardCast API in Crystal.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  cardcast:
    github: z64/cardcast
```

## Usage

```crystal
require "cardcast"

CardCast.deck("KW8B6") # => DeckInfo
CardCast.cards("KW8B6") # => Deck
```

## Contributors

- [z64](https://github.com/z64) Zac Nowicki - creator, maintainer
