//
//  PokedexRegion.swift
//  Pokedex
//
//  Created by Ricardo Salotti on 26/06/25.
//

import Foundation

///Model final da lista de Pokédex por região.
struct PokedexRegion {
    let entries: [PokedexRegionEntry]
}

struct PokedexRegionEntry: Identifiable, Hashable {
    let id: Int
    let name: String
    let displayName: String
}
