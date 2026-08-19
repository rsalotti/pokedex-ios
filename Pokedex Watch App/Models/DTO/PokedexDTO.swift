//
//  PokedexDTO.swift
//  Pokedex Watch App
//
//  Created by Ricardo Salotti on 19/08/25.
//

import Foundation

///Resposta de `/pokedex/{id}/`.
struct PokedexDTO: Decodable {
    let id: Int
    let name: String
    let isMainSeries: Bool
    let descriptions: [PokedexDescriptionDTO]
    let names: [PokedexNameDTO]
    let pokemonEntries: [PokedexEntryDTO]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isMainSeries = "is_main_series"
        case descriptions
        case names
        case pokemonEntries = "pokemon_entries"
    }
}

struct PokedexDescriptionDTO: Decodable {
    let description: String
    let language: NamedResourceDTO
}

struct PokedexNameDTO: Decodable {
    let name: String
    let language: NamedResourceDTO
}

struct PokedexEntryDTO: Decodable {
    let entryNumber: Int
    let pokemonSpecies: NamedResourceDTO

    enum CodingKeys: String, CodingKey {
        case entryNumber = "entry_number"
        case pokemonSpecies = "pokemon_species"
    }
}
