//
//  PokemonSpecies.swift
//  Pokedex
//
//  Created by Ricardo Salotti on 10/06/25.
//

import Foundation

struct PokemonSpecies: Codable {
    let flavorTextEntries: [FlavorTextEntry]
    
    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
}

struct FlavorTextEntry: Codable {
    let flavorText: String
    let language: FlavorLanguage
    let version: FlavorVersion
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
        case version
    }
}

struct FlavorLanguage: Codable {
    let name: String
    let url: String
}

struct FlavorVersion: Codable {
    let name: String
    let url: String
}
