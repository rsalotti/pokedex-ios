//
//  PokedexMapper.swift
//  Pokedex Watch App
//
//  Created by Ricardo Salotti on 19/08/25.
//

import Foundation

enum PokedexMapper: DTOMapper {
    static func map(_ dto: PokedexDTO) -> Pokedex {
        return Pokedex(
            id: dto.id,
            name: dto.name,
            isMainSeries: dto.isMainSeries,
            description: description(from: dto, languageCode: L10n.Key.en),
            entries: dto.pokemonEntries.map { entry(from: $0) }
        )
    }

    private static func entry(from dto: PokedexEntryDTO) -> PokedexEntry {
        return PokedexEntry(
            id: dto.entryNumber,
            name: dto.pokemonSpecies.name,
            displayName: dto.pokemonSpecies.name.capitalizedFirstLetter(),
            artworkURL: PokeAPIRules.artworkURL(forNationalID: dto.entryNumber)
        )
    }

    private static func description(from dto: PokedexDTO, languageCode: String) -> String? {
        return dto.descriptions.first { $0.language.name == languageCode }?.description
    }
}
