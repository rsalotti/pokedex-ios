//
//  Pokedex.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 26/08/24.
//

import Foundation

struct Pokedex: Codable {
    let descriptions: [PKDDescription]
    let id: Int
    let isMainSeries: Bool
    let name: String
    let names: [PKDName]
    let pokemonEntries: [PKDPokemonEntry]
    
    enum CodingKeys: String, CodingKey {
        case descriptions
        case id
        case isMainSeries = "is_main_series"
        case name
        case names
        case pokemonEntries = "pokemon_entries"
    }
}

struct PKDDescription: Codable {
    let description: String
    let language: PKDLanguage
}

struct PKDLanguage: Codable {
    let name: String
    let url: String
}

struct PKDName: Codable {
    let language: PKDLanguage
    let name: String
}

struct PKDPokemonEntry: Codable, Identifiable {
    let id: Int
    let pokemonSpecies: PKDPokemonSpecies
    
    enum CodingKeys: String, CodingKey {
        case id = "entry_number"
        case pokemonSpecies = "pokemon_species"
    }
}

struct PKDPokemonSpecies: Codable {
    let name: String
    let url: String
}
