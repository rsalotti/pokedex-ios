//
//  PokemonTypeFilterMapper.swift
//  Pokedex Watch App
//
//  Created by Ricardo Salotti on 19/08/25.
//

import Foundation

enum PokemonTypeFilterMapper: DTOMapper {
    static func map(_ dto: PokemonTypeDetailDTO) -> PokemonTypeFilter {
        return PokemonTypeFilter(
            type: PokemonType(rawValue: dto.name),
            nationalPokedexIDs: nationalPokedexIDs(from: dto.pokemon)
        )
    }

    ///O id do Pokémon só aparece na URL do recurso. Formas alternativas (id > 10000)
    ///não existem na Pokédex Nacional, então não entram no filtro.
    private static func nationalPokedexIDs(from dtos: [PokemonTypeSlotEntryDTO]) -> Set<Int> {
        let ids = dtos.compactMap { $0.pokemon.url.pokeAPIResourceID }
        return Set(ids.filter { $0 <= PokeAPIRules.lastNationalEntryID })
    }
}
