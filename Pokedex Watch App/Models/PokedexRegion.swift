//
//  PokedexRegion.swift
//  Pokedex
//
//  Created by Ricardo Salotti on 26/06/25.
//

import Foundation

struct PokedexRegion: Codable {
    let results: [RegionEntry]
}

struct RegionEntry: Codable {
    let name: String
    let url: String
}
