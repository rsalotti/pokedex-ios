//
//  PokedexRegionMapper.swift
//  Pokedex Watch App
//
//  Created by Ricardo Salotti on 19/08/25.
//

import Foundation

enum PokedexRegionMapper: DTOMapper {
    static func map(_ dto: PokedexRegionDTO) -> PokedexRegion {
        return PokedexRegion(
            entries: dto.results.compactMap { entry(from: $0) }
        )
    }

    ///O id de cada Pokédex só existe dentro da própria URL do recurso.
    private static func entry(from dto: NamedResourceDTO) -> PokedexRegionEntry? {
        guard let id = dto.url.pokeAPIResourceID else { return nil }
        return PokedexRegionEntry(
            id: id,
            name: dto.name,
            displayName: dto.name.capitalizedFirstLetter()
        )
    }
}
