//
//  Fixtures.swift
//  Pokedex Watch AppTests
//
//  Created by Ricardo Salotti on 19/08/25.
//

import Foundation

///JSON reduzido, mas com o mesmo formato que a PokeAPI devolve.
///As respostas reais são grandes demais para caber num teste legível, então cada
///fixture guarda só os campos que os DTOs decodificam, mais o que o teste precisa exercitar.
enum Fixtures {
    static func data(_ json: String) -> Data {
        return Data(json.utf8)
    }

    ///Tipos e stats fora de ordem de propósito: o mapper tem que normalizar os dois.
    static let charizard = #"""
    {
      "id": 6,
      "name": "charizard",
      "order": 7,
      "base_experience": 267,
      "height": 17,
      "weight": 905,
      "stats": [
        { "base_stat": 100, "effort": 0, "stat": { "name": "speed", "url": "https://pokeapi.co/api/v2/stat/6/" } },
        { "base_stat": 78,  "effort": 0, "stat": { "name": "hp", "url": "https://pokeapi.co/api/v2/stat/1/" } },
        { "base_stat": 109, "effort": 3, "stat": { "name": "special-attack", "url": "https://pokeapi.co/api/v2/stat/4/" } },
        { "base_stat": 84,  "effort": 0, "stat": { "name": "attack", "url": "https://pokeapi.co/api/v2/stat/2/" } },
        { "base_stat": 85,  "effort": 0, "stat": { "name": "special-defense", "url": "https://pokeapi.co/api/v2/stat/5/" } },
        { "base_stat": 78,  "effort": 0, "stat": { "name": "defense", "url": "https://pokeapi.co/api/v2/stat/3/" } }
      ],
      "types": [
        { "slot": 2, "type": { "name": "flying", "url": "https://pokeapi.co/api/v2/type/3/" } },
        { "slot": 1, "type": { "name": "fire", "url": "https://pokeapi.co/api/v2/type/10/" } }
      ],
      "sprites": {
        "front_default": "https://sprites.test/pokemon/6.png",
        "other": {
          "official-artwork": { "front_default": "https://sprites.test/official-artwork/6.png" }
        }
      }
    }
    """#

    ///Sem bloco `other`: o mapper tem que cair no template pelo número nacional.
    static let pokemonWithoutArtwork = #"""
    {
      "id": 25,
      "name": "pikachu",
      "order": 35,
      "base_experience": 112,
      "height": 4,
      "weight": 60,
      "stats": [
        { "base_stat": 35, "effort": 0, "stat": { "name": "hp", "url": "https://pokeapi.co/api/v2/stat/1/" } }
      ],
      "types": [
        { "slot": 1, "type": { "name": "electric", "url": "https://pokeapi.co/api/v2/type/13/" } }
      ],
      "sprites": {
        "front_default": "https://sprites.test/pokemon/25.png"
      }
    }
    """#

    ///`front_default` nulo e campos desconhecidos: nada disso pode derrubar a decodificação.
    static let pokemonWithNullSpritesAndUnknownEntries = #"""
    {
      "id": 999,
      "name": "missingno",
      "order": -1,
      "base_experience": 0,
      "height": 0,
      "weight": 0,
      "stats": [
        { "base_stat": 10, "effort": 0, "stat": { "name": "accuracy", "url": "https://pokeapi.co/api/v2/stat/7/" } },
        { "base_stat": 20, "effort": 0, "stat": { "name": "hp", "url": "https://pokeapi.co/api/v2/stat/1/" } }
      ],
      "types": [
        { "slot": 1, "type": { "name": "bird", "url": "https://pokeapi.co/api/v2/type/99/" } }
      ],
      "sprites": {
        "front_default": null,
        "other": { "official-artwork": { "front_default": null } }
      }
    }
    """#

    static let nationalPokedex = #"""
    {
      "id": 1,
      "name": "national",
      "is_main_series": true,
      "descriptions": [
        { "description": "Pokedex Nacional", "language": { "name": "pt", "url": "https://pokeapi.co/api/v2/language/8/" } },
        { "description": "National Pokedex", "language": { "name": "en", "url": "https://pokeapi.co/api/v2/language/9/" } }
      ],
      "names": [
        { "name": "National", "language": { "name": "en", "url": "https://pokeapi.co/api/v2/language/9/" } }
      ],
      "pokemon_entries": [
        { "entry_number": 1, "pokemon_species": { "name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon-species/1/" } },
        { "entry_number": 4, "pokemon_species": { "name": "charmander", "url": "https://pokeapi.co/api/v2/pokemon-species/4/" } },
        { "entry_number": 6, "pokemon_species": { "name": "charizard", "url": "https://pokeapi.co/api/v2/pokemon-species/6/" } }
      ]
    }
    """#

    ///O `\f` e as quebras de linha reproduzem a caixa de texto dos jogos.
    static let charizardSpecies = #"""
    {
      "flavor_text_entries": [
        {
          "flavor_text": "Il crache un feu\nsi chaud.",
          "language": { "name": "fr", "url": "https://pokeapi.co/api/v2/language/5/" },
          "version": { "name": "red", "url": "https://pokeapi.co/api/v2/version/1/" }
        },
        {
          "flavor_text": "Spits fire that\nis hot enough to\fmelt boulders.   Known to cause\nforest fires.",
          "language": { "name": "en", "url": "https://pokeapi.co/api/v2/language/9/" },
          "version": { "name": "red", "url": "https://pokeapi.co/api/v2/version/1/" }
        },
        {
          "flavor_text": "Segunda entrada em ingles",
          "language": { "name": "en", "url": "https://pokeapi.co/api/v2/language/9/" },
          "version": { "name": "blue", "url": "https://pokeapi.co/api/v2/version/2/" }
        }
      ]
    }
    """#

    ///Inclui uma forma alternativa (id 10034) que não existe na Pokédex Nacional.
    static let fireType = #"""
    {
      "name": "fire",
      "pokemon": [
        { "slot": 1, "pokemon": { "name": "charmander", "url": "https://pokeapi.co/api/v2/pokemon/4/" } },
        { "slot": 1, "pokemon": { "name": "charizard", "url": "https://pokeapi.co/api/v2/pokemon/6/" } },
        { "slot": 1, "pokemon": { "name": "charizard-mega-x", "url": "https://pokeapi.co/api/v2/pokemon/10034/" } }
      ]
    }
    """#

    static let unknownType = #"""
    {
      "name": "stellar",
      "pokemon": [
        { "slot": 1, "pokemon": { "name": "terapagos", "url": "https://pokeapi.co/api/v2/pokemon/1024/" } }
      ]
    }
    """#

    ///A última entrada tem URL sem id: o mapper deve descartá-la em vez de quebrar.
    static let pokedexRegions = #"""
    {
      "results": [
        { "name": "national", "url": "https://pokeapi.co/api/v2/pokedex/1/" },
        { "name": "original-johto", "url": "https://pokeapi.co/api/v2/pokedex/3/" },
        { "name": "quebrado", "url": "https://pokeapi.co/api/v2/pokedex/" }
      ]
    }
    """#
}
